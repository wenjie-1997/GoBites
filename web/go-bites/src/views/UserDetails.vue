<template>
<div id="user-details">
    <div class="user-form-details" v-if="userExist && userId!='-1'">
        <div class="customer-details" v-if="userType.toLowerCase() === 'customer'">
            <h1>Customer Info</h1>
            <form action="#">
                <div class="form-content">
                    <div class="form-group">
                        <label for="id">Id</label>
                        <input type="text" name="id" :value="getCustomerId" readonly />
                    </div>

                    <div class="form-group">
                        <label for="type">Type</label>
                        <input type="text" name="type" :value="getCustomerPersonId" readonly />
                    </div>

                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" name="name" :value="contact" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" name="address" :value="address" :readonly="readOnlyStatus" />
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

        <div class="restaurant-details" v-if="userType.toLowerCase() === 'restaurant'">
            <h1>Restaurant Info</h1>
            <form action="#">
                <div class="form-content">
                    <div class="form-group">
                        <label for="id">Id</label>
                        <input type="text" name="id" :value="getRestaurantId" readonly />
                    </div>

                    <div class="form-group">
                        <label for="type">Type</label>
                        <input type="text" name="type" :value="getRestaurantType" readonly />
                    </div>

                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" name="name" :value="getRestaurantName" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="address">Address</label>
                        <input type="text" name="address" :value="getRestaurantAddress" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" name="city" :value="getRestaurantCity" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="state">State</label>
                        <input type="text" name="state" :value="getRestaurantState" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="zipCode">Zip Code</label>
                        <input type="text" name="zipCode" :value="getRestaurantZipCode" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="country">Country</label>
                        <input type="text" name="country" :value="getRestaurantCountry" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="totalOrderMade">Rating</label>
                        <input type="text" name="totalOrderMade" :value="getRestaurantRating" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="totalCustomer">Total Customer</label>
                        <input type="text" name="totalCustomer" :value="getRestaurantTotalCustomer" :readonly="readOnlyStatus" />
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

        <div class="delivery-driver-details" v-if="userType.toLowerCase() === 'delivery-driver'">
            <h1>Delivery Driver Info</h1>
            <form action="#">
                <div class="form-content">
                    <div class="form-group">
                        <label for="id">Id</label>
                        <input type="text" name="id" :value="getDeliveryDriverId" readonly />
                    </div>

                    <div class="form-group">
                        <label for="type">Type</label>
                        <input type="text" name="type" :value="getDeliveryDriverType" readonly />
                    </div>

                    <div class="form-group">
                        <label for="name">Name</label>
                        <input type="text" name="name" :value="getDeliveryDriverName" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="age">Age</label>
                        <input type="text" name="address" :value="getDeliveryDriverAge" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="gender">Gender</label>
                        <input type="text" name="gender" :value="getDeliveryDriverGender" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="deliveryMethod">Delivery Method</label>
                        <input type="text" name="deliveryMethod" :value="getDeliveryDriverDeliveryMethod" :readonly="readOnlyStatus" />
                    </div>

                    <div class="form-group">
                        <label for="workArea">Work Area</label>
                        <input type="text" name="workArea" :value="getDeliveryDriverWorkArea" :readonly="readOnlyStatus" />
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
import {
    mapGetters
} from "vuex";

import ContactDataService from "../services/ContactDataService";
import AddressDataService from "../services/AddressDataService";

export default {
    name: 'User-Details',
    data() {
        return {
            userExist: false,
            userId: '-1',
            userType: 'none',
            readOnlyStatus: true,
            address: null,
            contact: null,
        }
    },
    created() {
        let urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('id')) {
            this.userExist = true;
            this.userId = urlParams.get('id');
            this.userType = urlParams.get('type');
            this.retrieveUserAddress();
            this.retrieveUserContact();
        } else {
            this.userExist = false;
            this.userId = '-1';
            this.$router.back();
        }

        if (this.getCustomerId == "" && this.userType.toLowerCase() === "customer") {
            this.$router.push('/customer');
            return;
        } else if (this.getRestaurantId == "" && this.userType.toLowerCase() === "restaurant") {
            this.$router.push('/restaurant');
            return;
        } else if (this.getDeliveryDriverId == "" && this.userType.toLowerCase() === "delivery-driver") {
            this.$router.push('/deliveryDriver');
            return;
        }
    },
    methods: {
        retrieveUserAddress() {
            if(this.userType.toLowerCase() === "customer") {
                AddressDataService.getAAddressPersonInformation(this.getCustomerPersonId)
                    .then(resp => {
                        this.address = resp.data;
                        console.log(this.address)
                    })
                    .catch(err => {
                        console.log(`${err.message} from UserDetails.vue`);
                    })  

            }else if(this.userType.toLowerCase() === "delivery-driver") {
                console.log("delivery-driver");
            }else if(this.userType.toLowerCase() === "restaurant") {
                console.log("restaurant");
            }
        },
        retrieveUserContact() {
            if(this.userType.toLowerCase() === "customer") {
                ContactDataService.getAContactPersonInformation(this.getCustomerPersonId)
                    .then(resp => {
                        this.contact = resp.data;
                        console.log(this.contact)
                    })
                    .catch(err => {
                        console.log(`${err.message} from UserDetails.vue`);
                    })

            }else if(this.userType.toLowerCase() === "delivery-driver") {
                console.log("delivery-driver");
            }else if(this.userType.toLowerCase() === "restaurant") {
                console.log("restaurant");
            }
        },
        editInfo: function () {
            this.readOnlyStatus = false;
        },
        saveInfo: function () {
            this.readOnlyStatus = true;
        },
        cancelEditInfo: function () {
            this.readOnlyStatus = true;
        },
        back: function () {
            if (this.userType.toLowerCase() === "restaurant") {
                this.$router.push('/restaurant');
            } else if (this.userType.toLowerCase() === "customer") {
                this.$router.push('/customer');
            } else if (this.userType.toLowerCase() === "delivery-driver") {
                this.$router.push('/deliveryDriver');
            }

        },
        deleteUser: function () {
            if (window.confirm(`Delete user with id ${this.userId}`)) {
                console.log("Deleting user");
            }
        }
    },
    computed: {
        ...mapGetters([
            "getCustomerId",
            "getCustomerPersonId",
            "getCustomerUserName",

            "getRestaurantId",
            "getRestaurantType",
            "getRestaurantName",
            "getRestaurantAddress",
            "getRestaurantCity",
            "getRestaurantState",
            "getRestaurantZipCode",
            "getRestaurantCountry",
            "getRestaurantRating",
            "getRestaurantTotalCustomer",

            "getDeliveryDriverId",
            "getDeliveryDriverType",
            "getDeliveryDriverName",
            "getDeliveryDriverAge",
            "getDeliveryDriverGender",
            "getDeliveryDriverDeliveryMethod",
            "getDeliveryDriverWorkArea",
        ])
    }
}
</script>

<style lang="scss">
.customer-details,
.restaurant-details,
.delivery-driver-details {
    text-align: center;
}

.user-form-details {
    width: 450px;
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
        padding: 5px 5px 5px 5px;
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
                margin: 5px 5px 5px 5px;
            }
        }

        &:hover {
            border: 10px outset rgb(117, 207, 235);
            padding: 10px 10px 10px 10px;
            box-shadow: 5px 5px 10px;
            transition: 0.2s;
        }
    }
}
</style>
