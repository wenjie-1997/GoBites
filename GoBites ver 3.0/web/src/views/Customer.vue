<template>
<div id="Customer">
    <div v-if='isLoading'>
        <h3>Retrieving data...</h3>
        <loading v-if='isLoading' />
    </div>

    <div v-if='!(customers === undefined) && !isLoading'>
        <div v-if="customersData.length > 0">
            <Search @displaySearchResult="displaySearchResult" @reset="reset" :conditions="conditions" />
        </div>
        <DisplayInformation @viewUserDetails="viewUserDetails" :userType="userType" :initialNo="initialNo" :users="customersData" :userLabels="customerLabels" :unWantedProperty="unWantedProperty" />
        <Pagination @getProcessedData='getProcessedData' :infoData="searching? searchResult : customers" :userType="userType" :numberOfInformationPerPage="numberOfInformationPerPage" />
    </div>
</div>
</template>

<script>
import CustomerDataService from '../services/CustomerDataService';
import loading from '../mixins/loading.vue';
import DisplayInformation from '../components/DisplayInformation.vue';
import Search from '../components/search/Search.vue';
import Pagination from '../components/Pagination.vue';

export default {
    name: 'customer',
    components: {
        loading,
        DisplayInformation,
        Search,
        Pagination,
    },
    data() {
        return {
            customers: [],
            customersData: [],
            isLoading: false,
            userType: "customer",
            unWantedProperty: "none",

            searchResult: [],
            noSearchResultFound: false,
            searching: false,

            numberOfInformationPerPage: 10,
            
            initialNo: 0,

            conditions: [
                {
                    condition :"Customer Name",
                    toggle :"no",
                },
            ],

            customerLabels: [
                {label: "No"},
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
                    for (var i = 0; i < Object.keys(response.data).length; i++) {
                        this.customers.push(response.data[i]);
                    }
                }).catch(err => {
                    this.isLoading = false;
                    alert(err.message);
                })
        },
        viewUserDetails: function (customer) {
            this.$router.push('/userDetails?id=' + customer.CID + '&type=customer');
        },
        displaySearchResult(requiredInformation, selectedConditions) {
            this.searchResult = [];

            if(selectedConditions !== undefined && selectedConditions.length > 0) {
                for(var i = 0; i < selectedConditions.length; i++) {
                    if(selectedConditions[i] === "Customer Name") {
                        this.searchByCustname(requiredInformation);
                    }
                }
                if(this.noSearchResultFound) {
                    alert("No Result found");
                }
                else {
                    this.searching = true;
                    this.initialNo = 0;
                }
            }else {
                alert("No filter had been chosen");
            }
        },
        searchByCustname(requiredInformation) {
            for(var i = 0; i < this.customers.length; i++) {
                if(this.customers[i].custname.toLowerCase().search(requiredInformation.toLowerCase()) != -1) {
                    if(this.duplicationDataChecker(this.customers[i]))
                        continue;
                    
                    this.searchResult.push(this.customers[i]);
                }
            }
            if(this.searchResult.length >= 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },  
        duplicationDataChecker(customerFound) {
            for(var i = 0; i < this.searchResult.length; i++) {
                if(this.searchResult[i] == customerFound) {
                    return true;
                }
            }
            return false;
        },
        reset() {
            this.searching = false;
        },
        getProcessedData(processedData, currentPage) {
            this.initialNo = (currentPage - 1) * this.numberOfInformationPerPage;
            this.customersData = processedData;
        },
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
    display: block;
    margin-left: auto;
    margin-right: auto;
}
</style>
