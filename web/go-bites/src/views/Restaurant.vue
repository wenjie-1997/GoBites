<template>
<div id="restaurant">
    <div class="restaurants-list">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="restaurants">
            <thead>
                <tr>
                    <th :colspan="Object.keys(this.restaurants[0]).length + 1">
                        <h3>Restaurant Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="(value, propertyName, index) in restaurants[0]" :key="index" >
                        {{ propertyName && propertyName !== "id"? propertyName.substring(10): "No" }}
                    </th>
                    <th>
                        More Details
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="restaurant in restaurants" :key="restaurant.id">
                    <td v-for="(value, propertyName, index) in restaurant" :key="index" >
                        {{ value }}
                    </td>
                    <td>
                        <input type="button" @click="viewUserDetails(restaurant)" value="More Details" />
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
import {
    SET_RESTAURANT_USER_STATE
} from "../store/actions/restaurantUser"

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
                })
        },
        viewUserDetails: function (restaurant) {
            this.$store.dispatch(SET_RESTAURANT_USER_STATE, {
                restaurant
            });
            this.$router.push('/userDetails?id=' + restaurant.id + '&type=' + restaurant.type.toLowerCase());
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllRestaurantsInformation();
    },
}
</script>

<style lang="scss">
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
</style>
