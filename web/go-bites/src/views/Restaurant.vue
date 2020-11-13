<template>
<div id="restaurant">
    <h3>Restaurant Page</h3>
    <div class="restaurants-list">
        <table>
            <tr>
                <th>Id</th>
                <th>Type</th>
                <th>Name</th>
                <th>Address</th>
                <th>City</th>
                <th>State</th>
                <th>Zip Code</th>
                <th>Country</th>
                <th>Rating</th>
                <th>Total Customer</th>
            </tr>
            <tr v-for="restaurant in restaurants" :key="restaurant.id">
                <td>{{ restaurant.id }}</td>
                <td>{{ restaurant.type }}</td>
                <td>{{ restaurant.name }}</td>
                <td>{{ restaurant.address }}</td>
                <td>{{ restaurant.city }}</td>
                <td>{{ restaurant.state}}</td>
                <td>{{ restaurant.zipCode }}</td>
                <td>{{ restaurant.Country }}</td>
                <td>{{ restaurant.rating }}</td>
                <td>{{ restaurant.totalCustomer }}</td>
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

export default {
    name: 'Restaurant',
    data() {
        return {
            restaurants
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
