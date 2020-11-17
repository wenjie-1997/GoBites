<template>
<div id="restaurant">
    <h3>Restaurant Page</h3>
    <div class="restaurants-list">
        <table>
            <tr>
                <th>Name</th>
                <th>Rating</th>
                <th>Total Customer</th>
                <th>More Details</th>
            </tr>
            <tr v-for="restaurant in restaurants" :key="restaurant.id">
                <td>{{ restaurant.name }}</td>
                <td>{{ restaurant.rating }}</td>
                <td>{{ restaurant.totalCustomer }}</td>
                <td>
                    <input type="button" @click="viewUserDetails(restaurant)" value="More Details" />
                </td>
            </tr>
            <tr>
                <th class="last-cell" colspan="10"></th>
            </tr>
        </table>
    </div>
</div>
</template>

<script>
import {
    restaurants
} from '../assets/users/restaurants'

import {
    SET_RESTAURANT_USER_STATE
} from "../store/actions/restaurantUser"

export default {
    name: 'Restaurant',
    data() {
        return {
            restaurants,
            urlPath: '/userDetails',
            userId: ''
        }
    },
    methods: {
        viewUserDetails: function (restaurant) {
            this.$store.dispatch(SET_RESTAURANT_USER_STATE, {
                restaurant
            });
            this.$router.push('/userDetails?id=' + restaurant.id + '&type=' + restaurant.type.toLowerCase());
        }
    }
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
