<template>
<div id="restaurant">
    <loading v-if='isLoading' />

    <UserInformation v-if="restaurants" @viewUserDetails="viewUserDetails" :userType="userType" :users="restaurants" :userLabels="restaurantLabels" :unWantedProperty="unWantedProperty" />
</div>
</template>

<script>
import RestaurantDataService from '../services/RestaurantDataService';
import loading from '../mixins/loading.vue';
import UserInformation from '../components/UserInformation.vue';

export default {
    name: 'Restaurant',
    components: {
        loading,
        UserInformation
    },
    data() {
        return {
            restaurants: null,
            isLoading: false,
            unWantedProperty: 'fk_mlid',
            userType: 'restaurant',

            restaurantLabels: [
                {label: "ID"},
                {label: "Name"},
                {label: "Owner"},
                {label: "Address"},
                {label: "Style"},
                {label: "Email"},
                {label: "Contact Number"},
                {label: "Manage User"},
            ]
        }
    },
    methods: {
        async retrieveAllRestaurantsInformation() {
            await RestaurantDataService.getAllRestaurantsInformation()
                .then(response => {
                    this.isLoading = false;
                    this.restaurants = response.data;
                }).catch(err => {
                    alert(err.message);
                });
        },
        viewUserDetails: function (restaurant) {
            this.$router.push('/userDetails?id=' + restaurant.RID + '&type=restaurant');
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllRestaurantsInformation();
    },
}
</script>

<style lang="scss">
#restaurant {
    width: 80%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    /* IE 9 */
    -webkit-transform: translate(-50%, -50%);
    /* Chrome, Safari, Opera */
}

</style>
