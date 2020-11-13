<template>
<div id="DeliveryDriver">
    <h3>Delivery Driver Page</h3>
    <div class="delivery-drivers-list">
        <table>
            <tr>
                <th>Id</th>
                <th>Type</th>
                <th>Name</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Delivery Method</th>
                <th>Work Area</th>
            </tr>
            <tr v-for="deliveryDriver in deliveryDrivers" :key="deliveryDriver.id">
                <td>{{ deliveryDriver.id }}</td>
                <td>{{ deliveryDriver.type }}</td>
                <td>{{ deliveryDriver.name }}</td>
                <td>{{ deliveryDriver.age }}</td>
                <td>{{ deliveryDriver.gender }}</td>
                <td>{{ deliveryDriver.deliveryMethod}}</td>
                <td>{{ deliveryDriver.workArea }}</td>
            </tr>
            <tr>
                <th class="last-cell" colspan="7"></th>
            </tr>
        </table>
    </div>
</div>
</template>

<script>
import {
    deliveryDrivers
} from '../assets/users/delivery-drivers'

export default {
    name: 'deliveryDriver',
    data() {
        return {
            deliveryDrivers
        }
    }
}
</script>

<style lang="scss" scoped>
.delivery-drivers-list {
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
