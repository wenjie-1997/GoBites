<template>
<div id="Customer">
    <div class="customers-list">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="customers">
            <thead>
                <tr>
                    <th :colspan="Object.keys(this.customers[0]).length + 2">
                        <h3>Customer Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="(value, propertyName, index) in customers[0]" :key="index" >
                        {{ propertyName && propertyName !== "id" ? propertyName.substring(8): "No" }}                
                    </th>
                    <th>
                        More Details
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="customer in customers" :key="customer.id">
                    <td v-for="(value, propertyName, index) in customer" :key="index" >
                        {{ value }}
                    </td>
                    <td>
                        <input type="button" @click="viewUserDetails(customer)" value="More Details" />
                    </td>
                </tr>
                <tr>
                    <th class="last-cell" :colspan="Object.keys(this.customers[0]).length + 2"></th>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</template>

<script>
import {
    SET_CUSTOMER_USER_STATE
} from '../store/actions/customerUser'

import CustomerDataService from '../services/CustomerDataService';
import UserDataService from '../services/UserDataService';
import loading from '../mixins/loading.vue'

export default {
    name: 'customer',
    components: {
        loading
    },
    data() {
        return {
            customers: null,
            users: null,
            urlPath: '/userDetails',
            userId: '',
            isLoading: false,
            fullPage: true,
            loader: 'bars',
        }
    },
    methods: {
        retrieveAllCustomersInformation() {
            CustomerDataService.getAllCustomersInformation()
                .then(response => {
                    this.customers = response.data;
                }).catch(err => {
                    this.isLoading = false;
                    alert(err.message);
                })
        },
        retrieveAllCustomerUsername() {
            UserDataService.getAllCustomerUsernameWithTheSameType("customer")
                .then(response => {
                    this.users = response.data;
                }).catch(err => {
                    this.isLoading = false;
                    alert(err.message);
                })
        },
        viewUserDetails: function (customer) {
            this.$store.dispatch(SET_CUSTOMER_USER_STATE, {
                customer
            });
            this.$router.push('/userDetails?id=' + customer.id + '&type=customer');
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllCustomersInformation();
        this.retrieveAllCustomerUsername();
        this.isLoading = false;
    },
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
