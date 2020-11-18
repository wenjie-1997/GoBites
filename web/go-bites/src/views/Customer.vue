<template>
<div id="Customer">
    <h3>Customer Page</h3>
    <div class="customers-list">
        <table>
            <tr>
                <th>Name</th>
                <th>Total Order Made</th>
                <th>More Details</th>
            </tr>
            <tr v-for="customer in customers" :key="customer.id">
                <td>{{ customer.name }}</td>
                <td>{{ customer.totalOrderMade }}</td>
                <td>
                    <input type="button" @click="viewUserDetails(customer)" value="More Details" />
                </td>
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

import {
    SET_CUSTOMER_USER_STATE
} from '../store/actions/customerUser'

export default {
    name: 'customer',
    data() {
        return {
            customers,
            urlPath: '/userDetails',
            userId: ''
        }
    },
    methods: {
        viewUserDetails: function (customer) {
            this.$store.dispatch(SET_CUSTOMER_USER_STATE, {
                customer
            });
            this.$router.push('/userDetails?id=' + customer.id + '&type=' + customer.type.toLowerCase());
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
