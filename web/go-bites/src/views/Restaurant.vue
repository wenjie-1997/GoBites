<template>
<div id="restaurant">
    <div class="table-responsive-sm">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="restaurants" class="table">
            <thead class="thead-dark">
                <tr>
                    <th :colspan="restaurantLabels.length" scope="col">
                        <h3>Restaurant Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="label in restaurantLabels" :key="label.label" scope="col">
                        {{ label.label }}
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="restaurant in restaurants" :key="restaurant.RID" scope="row">
                    <td v-for="(value, propertyName, index) in restaurant" :key="index" v-show="value && value !== 'fk_mlid' ">
                        {{ value && value.length > 15 ? value.substring(0, 15) + "..." : value}}
                    </td>
                    <td>
                        <input type="button" class="btn btn-primary form-control" @click="viewUserDetails(restaurant)" value="Manage" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</template>

<script>
import RestaurantDataService from '../services/RestaurantDataService';
import loading from '../mixins/loading.vue'

export default {
    name: 'Restaurant',
    components: {
        loading
    },
    data() {
        return {
            restaurants: null,
            urlPath: '/userDetails',
            userId: '',
            isLoading: false,
            fullPage: true,
            loader: 'bars',

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
        retrieveAllRestaurantsInformation() {
            RestaurantDataService.getAllRestaurantsInformation()
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
