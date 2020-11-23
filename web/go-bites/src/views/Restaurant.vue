<template>
<div id="restaurant">
    <div class="restaurants-list">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="restaurants">
            <thead>
                <tr>
                    <th :colspan="restaurantLabels.length">
                        <h3>Restaurant Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="label in restaurantLabels" :key="label.label">
                        {{ label.label }}
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="restaurant in restaurants" :key="restaurant.RID">
                    <td v-for="(value, propertyName, index) in restaurant" :key="index" v-show="value && value !== 'fk_mlid' ">
                        {{ value && value.length > 12 ? value.substring(0, 12) + "..." : value}}
                    </td>
                    <td>
                        <input type="button" class="btn btn-primary" @click="viewUserDetails(restaurant)" value="Manage" />
                    </td>
                </tr>
                <tr>
                    <th class="last-cell" :colspan="Object.keys(this.restaurants[0]).length + 1"></th>
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

    .restaurants-list {
    text-align: center;

    table {
        margin-left: auto;
        margin-right: auto;

        td,
        th {
            padding: 10px 10px 10px 10px;
            border: 1px solid black;
        }

        td {
            border-bottom: none;
            border-top: none;
        }

        .last-cell {
            border: none;
            border-top: 1px solid black;
        }
    }
}
}

</style>
