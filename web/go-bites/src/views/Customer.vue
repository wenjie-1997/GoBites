<template>
<div id="Customer">
    <div class="table-responsive-sm">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <table v-if="customers" class="table">
            <thead class="thead-dark">
                <tr>
                    <th :colspan="customerLabels.length" scope="col">
                        <h3>Customer Page</h3>
                    </th>
                </tr>
                <tr>
                    <th v-for="label in customerLabels" :key="label.label" scope="col">
                        {{ label.label }}                
                    </th>
                </tr>
            </thead>

            <tbody>
                <tr v-for="customer in customers" :key="customer.CID">
                    <td v-for="(value, propertyName, index) in customer" :key="index" scope="row">
                        {{ value &&  value.length > 20 ? value.substring(0, 20) + "..." : value}}
                    </td>
                    <td>
                        <input type="button" class="btn btn-primary form-control" @click="viewUserDetails(customer)" value="Manage" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
</template>

<script>
import CustomerDataService from '../services/CustomerDataService';
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

            customerLabels: [
                {label :"ID"},
                {label :"Customer Name"},
                {label :"Birth Date"},
                {label :"Gender"},
                {label :"Address"},
                {label :"Email"},
                {label :"Contact Number"},
                {label :"Manage User"}
            ],
        }
    },
    methods: {
        retrieveAllCustomersInformation() {
            CustomerDataService.getAllCustomersInformation()
                .then(response => {
                    this.isLoading = false;
                    this.customers = response.data;
                }).catch(err => {
                    this.isLoading = false;
                    alert(err.message);
                })
        },
        viewUserDetails: function (customer) {
            this.$router.push('/userDetails?id=' + customer.CID + '&type=customer');
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllCustomersInformation();
    },
}
</script>

<style lang="scss">
#Customer {
    width: 80%;
    position: relative;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    /* IE 9 */
    -webkit-transform: translate(-50%, -50%);
    /* Chrome, Safari, Opera */
}
</style>
