<template>
<div id="DeliveryDriver">
    <div class="delivery-drivers-list">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="deliveryDrivers">
            <thead>
                <tr>
                    <th :colspan="Object.keys(this.deliveryDrivers[0]).length + 1">
                        <h3>Delivery Driver Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="(value, propertyName, index) in deliveryDrivers[0]" :key="index" >
                        {{ propertyName && propertyName !== "id" ? propertyName.substring(14): "No" }}
                    </th>
                    <th>
                        More Details
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="deliveryDriver in deliveryDrivers" :key="deliveryDriver.id">
                    <td v-for="(value, propertyName, index) in deliveryDriver" :key="index" >
                        {{ value }}
                    </td>
                    <td>
                        <input type="button" @click="viewUserDetails(deliveryDriver)" value="More Details" />
                    </td>
                </tr>
                <tr>
                    <th class="last-cell" :colspan="Object.keys(this.deliveryDrivers[0]).length + 1"></th>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</template>

<script>
import {
    SET_DELIVERY_DRIVER_USER_STATE
} from "../store/actions/deliveryDriverUser";

import DeliveryDriverDataService from '../services/DeliveryDriverDataService';
import loading from '../mixins/loading.vue'

export default {
    name: 'deliveryDriver',
    components: {
        loading
    },
    data() {
        return {
            deliveryDrivers: null,
            urlPath: '/userDetails',
            userId: '',
            isLoading: false,
            fullPage: true,
            loader: 'bars',
        }
    },
    methods: {
        retrieveAllDeliveryDriversInformation() {
            DeliveryDriverDataService.getAllDeliveryDriversInformation()
                .then(response => {
                    this.isLoading = false;
                    this.deliveryDrivers = response.data;
                }).catch(err => {
                    alert(err.message);
                })
        },
        viewUserDetails: function (deliveryDriver) {
            this.$store.dispatch(SET_DELIVERY_DRIVER_USER_STATE, {
                deliveryDriver
            });
            this.$router.push('/userDetails?id=' + deliveryDriver.id + '&type=' + deliveryDriver.type.toLowerCase());
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllDeliveryDriversInformation();
    },
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
