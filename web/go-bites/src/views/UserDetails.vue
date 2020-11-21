<template>
<div id="user-details">
    <div class="user-form-details" v-if="userExist && userId!='-1'">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <div class="customer-details" v-if="user">
            <h1>User Info</h1>
            <form action="#">
                <div class="form-content" v-if='!isLoading'>
                    <div class="form-group" v-for="(value, propertyName, index) in user" :key="index">
                        <label v-show="value"> {{ propertyName }}</label>
                        <input v-show="value" type="text" name="id" :value="value && value.length > 25? value.substring(0,25) + '...' : value" :readonly="readOnlyStatus || propertyName.toLowerCase().includes('rid') || propertyName.toLowerCase().includes('cid')" />
                    </div>

                    <div class="button-group">
                        <input class="btn btn-primary" type="button" @click="editInfo" value="Edit" v-if="readOnlyStatus" />
                        <input class="btn btn-primary" type="button" @click="saveInfo" value="Save" v-if="!readOnlyStatus" />
                        <input class="btn btn-primary" type="button" @click="cancelEditInfo" value="Cancel" v-if="!readOnlyStatus" />
                        <input class="btn btn-primary" type="button" @click="back" value="Back" v-if="readOnlyStatus" />
                        <input class="btn btn-primary" type="button" @click="deleteUser" value="Delete" v-if="readOnlyStatus" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
</template>

<script>
import CustomerDataService from '../services/CustomerDataService';
import RestaurantDataService from '../services/RestaurantDataService';

import loading from '../mixins/loading.vue'

export default {
    name: 'User-Details',
    components: {
        loading
    },
    data() {
        return {
            userExist: false,
            userId: '-1',
            userType: 'none',
            readOnlyStatus: true,
            user: null,
            isLoading: false,
            fullPage: true,
            loader: 'bars',
        }
    },
    created() {
        this.isLoading = true;
        let urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('id') && urlParams.has('type') ) {
            this.userId = urlParams.get('id');
            this.userType = urlParams.get('type');
            this.userExist = true;

            if(this.userType.toLowerCase() === "customer") {
                this.retrieveACustomerInformation();
            } else if(this.userType.toLowerCase() === "restaurant") {
                this.retrieveARestaurantInformation();
            } else {
                if (this.getCustomerId == "" && this.userType.toLowerCase() === "customer") {
                    this.$router.push('/customer');
                    return;
                } else if (this.getRestaurantId == "" && this.userType.toLowerCase() === "restaurant") {
                    this.$router.push('/restaurant');
                    return;
                }
            }
        } else {
            this.userExist = false;
            this.userId = '-1';
            this.$router.back();
        }
    },
    methods: {
        retrieveACustomerInformation() {
            CustomerDataService.getACustomerInformation(this.userId)
                .then(resp => {
                    this.isLoading = false;
                    this.user = resp.data[0];
                })
                .catch( err => {
                    this.isLoading = false;
                    console.log(err);
                });
        },
        retrieveARestaurantInformation() {
            this.isLoading = true;
            RestaurantDataService.getARestaurantInformation(this.userId)
                .then(resp => {
                    this.isLoading = false;
                    this.user = resp.data[0];
                })
                .catch( err => {
                    this.isLoading = false;
                    console.log(err);
                });
        },
        editInfo: function () {
            this.readOnlyStatus = false;
        },
        saveInfo: function () {
            this.readOnlyStatus = true;
            if (this.userType.toLowerCase() === "restaurant") {
                RestaurantDataService.updateARestaurantInformation(this.userId);
            } else if (this.userType.toLowerCase() === "customer") {
                CustomerDataService.updateACustomerInformation(this.userId);
            }
        },
        cancelEditInfo: function () {
            this.readOnlyStatus = true;
        },
        back: function () {
            if (this.userType.toLowerCase() === "restaurant") {
                this.$router.push('/restaurant');
            } else if (this.userType.toLowerCase() === "customer") {
                this.$router.push('/customer');
            }
        },
        deleteUser: function () {
            if (window.confirm(`Delete user with id ${this.userId}`)) {
                console.log("Deleting user");
            }
        }
    }
}
</script>

<style lang="scss">
.customer-details,
.restaurant-details{
    text-align: center;
}

.user-form-details {
    width: 50%;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    /* IE 9 */
    -webkit-transform: translate(-50%, -50%);
    /* Chrome, Safari, Opera */
    background-color: rgba(151, 38, 38, 0);

    .form-content {
        display: flex;
        flex-direction: column;
        align-items: center;
        background-color: rgba(184, 20, 20, 0);
        border: 10px inset rgb(117, 207, 235);
        padding: 10px 10px 10px 10px;
        box-shadow: inset 0 0 10px;
        transition: 0.2s;

        .form-group {
            display: flex;
            flex-direction: row;
            width: 90%;
            height: 90%;

            input {
                width: 65%;

                &:read-only {
                    background-color: rgb(226, 219, 219);
                    border: 2px outset rgb(226, 219, 219);
                }

                &:read-write {
                    background-color: rgb(255, 255, 255);
                    border: 2px inset rgb(226, 219, 219);
                }
            }

            label {
                text-align: left;
                width: 35%;
            }
        }

        .button-group {
            display: flex;
            flex-direction: row;

            input[type=button] {
                margin: 10px 10px 10px 10px;
            }
        }

        &:hover {
            border: 10px outset rgb(117, 207, 235);
            padding: 20px 20px 20px 20px;
            box-shadow: 5px 5px 10px;
            transition: 0.2s;
        }
    }
}
</style>
