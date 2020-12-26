<template>
<div id="orderList">
    <div v-if='isLoading'>
        <h3>Retrieving data...</h3>
        <loading v-if='isLoading' />
    </div>

    <div v-if='!(orders === undefined) && !isLoading'>
        <div v-if="ordersData.length > 0">
            <Search @displaySearchResult="displaySearchResult" @reset="reset" :conditions="conditions" />
        </div>
        
        <DisplayInformation v-if="orders" @viewUserDetails="viewUserDetails" :initialNo="initialNo" :userType="userType" :users="ordersData" :userLabels="orderLabels" :unWantedProperty="unWantedProperty" />
        <Pagination @getProcessedData='getProcessedData' :infoData="searching? searchResult : orders" :userType="userType" :numberOfInformationPerPage="numberOfInformationPerPage" />
    </div>
</div>
</template>

<script>
import OrderItemDataService from '../services/OrderItemDataService';
import loading from '../mixins/loading.vue';
import DisplayInformation from '../components/DisplayInformation.vue';
import Search from '../components/search/Search.vue';
import Pagination from '../components/Pagination.vue';

export default {
    name: 'OrderList',
    components: {
        loading,
        DisplayInformation,
        Search,
        Pagination,
    },
    data() {
        return {
            ordersData: [],
            orders: [],
            isLoading: false,
            unWantedProperty: 'fk_mlid',
            userType: 'order',

            searchResult: [],
            noSearchResultFound: false,
            searching: false,

            numberOfInformationPerPage: 10,

            initialNo: 0,

            conditions: [
                {
                    condition :"Order ID",
                    toggle :"no",
                },
                {
                    condition :"Customer Name",
                    toggle :"no",
                },
                {
                    condition :"Menu",
                    toggle :"no",
                },
            ],

            orderLabels: [
                {label: "No"},
                {label: "Customer Name"},
                {label: "Order ID"},
                {label: "Quantity"},
                {label: "Menu"},
                {label: "Price per Menu"},
                {label: "Total Price"},
            ]
        }
    },
    methods: {
        async retrieveAllOrdersInformation() {
            await OrderItemDataService.getAllOrderItems()
                .then(response => {
                    this.isLoading = false;
                    
                    for (var i = 0; i < Object.keys(response.data).length; i++) {
                        const order = {};
                        order.custname = response.data[i].order.customer.custname;
                        order.orderId = response.data[i].order.orderid;
                        order.quantity = response.data[i].quantity;
                        order.menu = response.data[i].MenuItem.itemName;
                        order.pricePerMenu = response.data[i].MenuItem.itemPrice;
                        order.totalPrice = response.data[i].order.totalPrice;

                        this.orders.push(order);
                    }
                }).catch(err => {
                    alert(err.message);
                });
        },
        viewUserDetails: function (order) {
            console.log("viewUserDetails is not used yet... " + order);
        },
        displaySearchResult(requiredInformation, selectedConditions) {
            this.searchResult = [];
            if(selectedConditions !== undefined && selectedConditions.length > 0) {
                for(var i = 0; i < selectedConditions.length; i++) {
                    if(selectedConditions[i] === "Order ID") {
                        this.searchByOrderID(requiredInformation);
                    }
                    else if(selectedConditions[i] === "Customer Name") {
                        this.searchByCustomerName(requiredInformation);
                    } 
                    else if (selectedConditions[i] === "Menu") {
                        this.searchByMenu(requiredInformation);
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
        searchByOrderID(requiredInformation) {
            for(var i = 0; i < this.orders.length; i++) {
                if(this.orders[i].orderId == requiredInformation) {
                    if(this.duplicationDataChecker(this.orders[i]))
                        continue;

                    this.searchResult.push(this.orders[i]);
                }
            }
            if(this.searchResult.length > 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },
        searchByCustomerName(requiredInformation) {
            for(var i = 0; i < this.orders.length; i++) {
                if(this.orders[i].custname.toLowerCase().search(requiredInformation.toLowerCase()) != -1) {
                    if(this.duplicationDataChecker(this.orders[i]))
                        continue;

                    this.searchResult.push(this.orders[i]);
                }
            }
            if(this.searchResult.length > 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },
        searchByMenu(requiredInformation) {
            for(var i = 0; i < this.orders.length; i++) {
                if(this.orders[i].menu.toLowerCase().search(requiredInformation.toLowerCase()) != -1) {
                    if(this.duplicationDataChecker(this.orders[i]))
                        continue;

                    this.searchResult.push(this.orders[i]);
                }
            }
            if(this.searchResult.length > 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },
        duplicationDataChecker(orderFound) {
            for(var i = 0; i < this.searchResult.length; i++) {
                if(this.searchResult[i] == orderFound) {
                    return true;
                }
            }
            return false;
        },
        reset() {
            this.searching = false;
        },
        unselectCondition(condition) {
            if(this.selectedConditions) {
                for (var i = 0; i < this.selectedConditions.length; i++) {
                    if(this.selectedConditions[i] === condition) {
                        this.selectedConditions.splice(i, 1);
                        break;
                    }
                }
            }
        },
        setSelectedCondition(condition) {
            this.selectedConditions.push(condition);
            console.log(this.selectedConditions);
        },
        getProcessedData(processedData, currentPage) {
            this.initialNo = (currentPage - 1) * this.numberOfInformationPerPage;
            this.ordersData = processedData;
        },
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllOrdersInformation();
    },
}
</script>

<style lang="scss">
#orderList {
    width: 80%;
    display: block;
    margin-left: auto;
    margin-right: auto;
}

</style>
