<template>
<div id="Customer">
    <loading v-if='isLoading' />

    <UserInformation v-if='customers' @viewUserDetails="viewUserDetails" :userType="userType" :users="customers" :userLabels="customerLabels" :unWantedProperty="unWantedProperty" />
</div>
</template>

<script>
import CustomerDataService from '../services/CustomerDataService';
import loading from '../mixins/loading.vue'
import UserInformation from '../components/UserInformation.vue'

export default {
    name: 'customer',
    components: {
        loading,
        UserInformation,
    },
    data() {
        return {
            customers: null,
            isLoading: false,
            userType: "customer",
            unWantedProperty: "none",

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
        async retrieveAllCustomersInformation() {
            await CustomerDataService.getAllCustomersInformation()
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
