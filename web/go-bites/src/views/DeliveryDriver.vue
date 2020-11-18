<template>
<div id="DeliveryDriver">
    <h3>Delivery Driver Page</h3>
    <div class="delivery-drivers-list">
        <table>
            <tr>
                <th>Name</th>
                <th>Delivery Method</th>
                <th>Work Area</th>
                <th>More Details</th>
            </tr>
            <tr v-for="deliveryDriver in deliveryDrivers" :key="deliveryDriver.id">
                <td>{{ deliveryDriver.name }}</td>
                <td>{{ deliveryDriver.deliveryMethod}}</td>
                <td>{{ deliveryDriver.workArea }}</td>
                <td>
                    <input type="button" @click="viewUserDetails(deliveryDriver)" value="More Details" />
                </td>
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

import {
    SET_DELIVERY_DRIVER_USER_STATE
} from "../store/actions/deliveryDriverUser";

export default {
    name: 'deliveryDriver',
    data() {
        return {
            deliveryDrivers,
            urlPath: '/userDetails',
            userId: ''
        }
    },
    methods: {
        viewUserDetails: function (deliveryDriver) {
            this.$store.dispatch(SET_DELIVERY_DRIVER_USER_STATE, {
                deliveryDriver
            });
            this.$router.push('/userDetails?id=' + deliveryDriver.id + '&type=' + deliveryDriver.type.toLowerCase());
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
