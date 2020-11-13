<template>
<div id="Customer">
    <h3>Customer Page</h3>
    <div class="customers-list">
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
                <th>Total Order Made</th>
            </tr>
            <tr v-for="customer in customers" :key="customer.id">
                <td>{{ customer.id }}</td>
                <td>{{ customer.type }}</td>
                <td>{{ customer.name }}</td>
                <td>{{ customer.address }}</td>
                <td>{{ customer.city }}</td>
                <td>{{ customer.state}}</td>
                <td>{{ customer.zipCode }}</td>
                <td>{{ customer.Country }}</td>
                <td>{{ customer.totalOrderMade }}</td>
            </tr>

            <tr>
                <th class="last-cell" colspan="9"></th>
            </tr>
        </table>
    </div>
</div>
</template>

<script>
import {
    customers
} from '../assets/users/customers'

export default {
    name: 'customer',
    data() {
        return {
            customers,
        }
    }
}
</script>

<style lang="scss">
.customers-list {
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
