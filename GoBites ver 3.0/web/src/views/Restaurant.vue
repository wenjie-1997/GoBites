<template>
    <div id="restaurant">
        <div v-if='isLoading'>
            <h3>Retrieving data...</h3>
            <loading v-if='isLoading' />
        </div>

        <div v-if='restaurants !== undefined && !isLoading'>
            <div v-if="restaurantsData.length > 0">
                <Search @displaySearchResult="displaySearchResult" @reset="reset" :conditions="conditions" />
            </div>
            <DisplayInformation v-if="restaurants" @viewUserDetails="viewUserDetails" :initialNo="initialNo" :userType="userType" :users="restaurantsData" :userLabels="restaurantLabels" :unWantedProperty="unWantedProperty" />
            <Pagination @getProcessedData='getProcessedData' :infoData="searching? searchResult : restaurants" :userType="userType" :numberOfInformationPerPage="numberOfInformationPerPage" />
        </div>
    </div>
</template>

<script>
import RestaurantDataService from '../services/RestaurantDataService';
import loading from '../mixins/loading.vue';
import DisplayInformation from '../components/DisplayInformation.vue';
import Search from '../components/search/Search.vue';
import Pagination from '../components/Pagination.vue';

export default {
    name: 'Restaurant',
    components: {
        loading,
        DisplayInformation,
        Search,
        Pagination,
    },
    data() {
        return {
            restaurantsData: [],
            restaurants: [],
            isLoading: false,
            unWantedProperty: 'fk_mlid',
            userType: 'restaurant',

            searchResult: [],
            noSearchResultFound: false,
            searching: false,

            initialNo: 0,

            numberOfInformationPerPage: 10,

            conditions: [
                {
                    condition :"Restaurant Name",
                    toggle :"no",
                },
                {
                    condition :"Restaurant Owner",
                    toggle :"no",
                },
            ],

            restaurantLabels: [
                {label: "No"},
                {label: "ID"},
                {label: "Name"},
                {label: "Owner"},
                {label: "Address"},
                {label: "Style"},
                {label: "Email"},
                {label: "Contact Number"},
                {label: "Manage User"},
            ]
        }
    },
    methods: {
        async retrieveAllRestaurantsInformation() {
            await RestaurantDataService.getAllRestaurantsInformation()
                .then(response => {
                    this.isLoading = false;
                    for (var i = 0; i < Object.keys(response.data).length; i++) {
                        this.restaurants.push(response.data[i]);
                    }
                }).catch(err => {
                    alert(err.message);
                });
        },
        viewUserDetails: function (restaurant) {
            this.$router.push('/userDetails?id=' + restaurant.RID + '&type=restaurant');
        },
        displaySearchResult(requiredInformation, selectedConditions) {
            this.searchResult = [];
            
            if(selectedConditions !== undefined && selectedConditions.length > 0) {
                for(var i = 0; i < selectedConditions.length; i++) {
                    if(selectedConditions[i] === "Restaurant Name") {
                        this.searchByRestaurantName(requiredInformation);
                    }
                    else if(selectedConditions[i] === "Restaurant Owner") {
                        this.searchByRestaurantOwner(requiredInformation);
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
        searchByRestaurantName(requiredInformation) {
            for(var i = 0; i < this.restaurants.length; i++) {
                if(this.restaurants[i].restaurantname.toLowerCase().search(requiredInformation.toLowerCase()) != -1) {
                    if(this.duplicationDataChecker(this.restaurants[i]))
                        continue;

                    this.searchResult.push(this.restaurants[i]);
                }
            }
            if(this.searchResult.length > 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },
        searchByRestaurantOwner(requiredInformation) {
            for(var i = 0; i < this.restaurants.length; i++) {
                if(this.restaurants[i].ownername.toLowerCase().search(requiredInformation.toLowerCase()) != -1) {
                    if(this.duplicationDataChecker(this.restaurants[i]))
                        continue;

                    this.searchResult.push(this.restaurants[i]);
                }
            }
            if(this.searchResult.length > 0){
                this.noSearchResultFound = false;
                return;
            }
            this.noSearchResultFound = true;
        },
        duplicationDataChecker(restaurantFound) {
            for(var i = 0; i < this.searchResult.length; i++) {
                if(this.searchResult[i] == restaurantFound) {
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
            this.restaurantsData = processedData;
        }
    },
    mounted() {
        this.isLoading = true;
        this.retrieveAllRestaurantsInformation();
    },
}
</script>

<style lang="scss">
#restaurant {
    width: 80%;
    display: block;
    margin-left: auto;
    margin-right: auto;
}

</style>
