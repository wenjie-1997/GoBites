<template>
<div id="user-details">
    <div class="user-form-details" v-if="userExist && userId!='-1'">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <div v-if="user">
            <h1 v-if="!isLoading && userType == 'customer'">Customer Info</h1>
            <h1 v-else-if="!isLoading && userType == 'restaurant'">Restaurant Info</h1>
            <h1 v-else-if="!isLoading && userType != 'customer' && userType != 'restaurant'">User Info</h1>
            <h1 v-if="isLoading">Processing...</h1>
            <form action="#" v-if="userType == 'customer' && !isLoading">
                <div class="form-row">
                    <div class="col-md-2 mb-3">
                        <label for="cid">ID</label>
                        <input type="number" id="cid" class="form-control" v-model="user.CID" readonly />
                    </div>

                    <div  class="col-md-10 mb-3">
                        <label for="customerName">Customer Name</label>
                        <input type="text" class="form-control" id="customerName" v-model="customer.custname" :readonly="readOnlyStatus" required />
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="col-md-6 mb-3">
                        <label>Birth Date</label>
                        <input type="date" class="form-control"  v-model="customer.birthdate" :readonly="readOnlyStatus" required />
                    </div>

                    <div class="col-md-6 mb-3">
                        <label>Email</label>
                        <input type="email" class="form-control" v-model="customer.email" :readonly="readOnlyStatus" required />
                    </div>
                </div>

                <div  class="form-row">
                    <div class="col-md-6 mb-3">
                        <label>Telephone No</label>
                        <input type="text" class="form-control" v-model="customer.telephoneNo" :readonly="readOnlyStatus" required />
                    </div>
                    <div class="col-md-6 mb-3">
                        <label>Gender</label>
                        <div>
                            <div class="form-check form-check-inline" >
                                <input type="radio" class="form-check-input" value="Female" name="gender" id="female" v-model="customer.gender" :disabled="readOnlyStatus">
                                <label class="form-check-label" for="female">Female</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input type="radio" class="form-check-input" value="Male" name="gender" id="male" v-model="customer.gender" :disabled="readOnlyStatus">
                                <label class="form-check-label" for="male">Male</label>
                            </div>
                    </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <textarea rows="4" type="text" class="form-control" v-model="customer.address" :readonly="readOnlyStatus" required />
                </div>

                <div class="button-group">
                    <input class="btn btn-primary btn-custom" type="button" @click="editInfo" value="Edit" v-if="readOnlyStatus" />
                    <input class="btn btn-primary btn-save btn-custom" type="button" @click="saveInfo" value="Save" v-if="!readOnlyStatus" />
                    <input class="btn btn-primary btn-custom" type="button" @click="cancelEditInfo" value="Cancel" v-if="!readOnlyStatus" />
                    <input class="btn btn-primary btn-custom" type="button" @click="back" value="Back" v-if="readOnlyStatus" />
                    <input class="btn btn-primary btn-delete btn-custom" type="button" @click="deleteUser" value="Delete" v-if="readOnlyStatus" />
                </div>
            </form>
            <form action="#" v-if="userType == 'restaurant'">

                <div v-if='!isLoading'>
                    <div class="form-row">
                        <div class="col-md-2 mb-3">
                            <label for="rid">ID</label>
                            <input type="number" id="rid" class="form-control" v-model="restaurant.RID" readonly />
                        </div>

                        <div  class="col-md-10 mb-3">
                            <label for="restaurantName">Restaurant Name</label>
                            <input type="text" class="form-control" id="restaurantName" v-model="restaurant.restaurantname" :readonly="readOnlyStatus" required />
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="col-md-2 mb-3">
                            <label for="restaurantStyle">Restaurant Style</label>
                            <input type="text" id="restaurantStyle" class="form-control" v-model="restaurant.restaurantstyle" :readonly="readOnlyStatus" />
                        </div>

                        <div  class="col-md-10 mb-3">
                            <label for="restaurantOwner">Restaurant Owner</label>
                            <input type="text" class="form-control" id="restaurantOwner" v-model="restaurant.ownername" :readonly="readOnlyStatus" required />
                        </div>
                    </div>

                    <div  class="form-group">
                        <label>Address</label>
                        <textarea rows="4" type="text" class="form-control" v-model="restaurant.address" :readonly="readOnlyStatus" required />
                    </div>

                    <div  class="form-row">
                        <div class="col-md-2 mb-3">
                            <label>Telephone No</label>
                            <input type="text" class="form-control" v-model="restaurant.telephoneNo" :readonly="readOnlyStatus" required />
                        </div>

                        <div class="col-md-10 mb-3">
                            <label>Email</label>
                            <input type="email" class="form-control" v-model="restaurant.email" :readonly="readOnlyStatus" required />
                        </div>
                    </div>

                    <div class="button-group">
                        <input class="btn btn-primary btn-custom" type="button" @click="editInfo" value="Edit" v-if="readOnlyStatus" />
                        <input class="btn btn-primary btn-save btn-custom" type="button" @click="saveInfo" value="Save" v-if="!readOnlyStatus" />
                        <input class="btn btn-primary btn-custom" type="button" @click="cancelEditInfo" value="Cancel" v-if="!readOnlyStatus" />
                        <input class="btn btn-primary btn-custom" type="button" @click="back" value="Back" v-if="readOnlyStatus" />
                        <input class="btn btn-primary btn-delete btn-custom" type="button" @click="deleteUser" value="Delete" v-if="readOnlyStatus" />
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

            customer: null,

            restaurant: null,
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
            this.isLoading = true;
            this.user = null;
            CustomerDataService.getACustomerInformation(this.userId)
                .then(resp => {
                    this.isLoading = false;
                    this.user = resp.data[0];

                    this.customer = this.user;
                })
                .catch( err => {
                    this.isLoading = false;
                    console.log(err);
                });
        },
        retrieveARestaurantInformation() {
            this.isLoading = true;
            this.user = null;
            RestaurantDataService.getARestaurantInformation(this.userId)
                .then(resp => {
                    this.isLoading = false;
                    this.user = resp.data[0];

                    this.restaurant = this.user;
                })
                .catch( err => {
                    this.isLoading = false;
                    console.log(err);
                });
        },
        editInfo: function () {
            this.readOnlyStatus = false;
        },
        saveInfo: async function () {
            this.readOnlyStatus = true;
            this.isLoading = true;
            if (this.userType.toLowerCase() === "customer") {
                const cid = this.user.CID;
                const custname = this.user.custname;
                const gender = this.user.gender;
                const birthdate = this.user.birthdate;
                const email = this.user.email;
                const address = this.user.address;
                
                this.user.CID = this.customer.CID;
                this.user.custname = this.customer.custname;
                this.user.gender = this.customer.gender;
                this.user.birthdate = this.customer.birthdate;
                this.user.email = this.customer.email;
                this.user.address = this.customer.address;

                await CustomerDataService.updateACustomerInformation(this.user)
                    .then(() => {
                        this.isLoading = false;
                        this.retrieveACustomerInformation();
                        alert("Successfully update");
                    })
                    .catch(err => {
                        this.isLoading = false;
                        console.log(err.message);

                        this.user.CID = cid;
                        this.user.custname = custname;
                        this.user.gender = gender;
                        this.user.birthdate = birthdate;
                        this.user.email = email;
                        this.user.address = address;

                        this.revertUserInformation();
                        alert("Fail to update");
                    })
                
            } else if (this.userType.toLowerCase() === "restaurant") {
                const rid = this.user.RID;
                const restaurantname = this.user.restaurantname;
                const ownername = this.user.ownername;
                const restaurantstyle = this.user.restaurantstyle;
                const telephoneNo = this.user.telephoneNo;
                const address = this.user.address;

                this.user.RID = this.restaurant.RID;
                this.user.restaurantname = this.restaurant.restaurantname;
                this.user.ownername = this.restaurant.ownername;
                this.user.restaurantstyle = this.restaurant.restaurantstyle;
                this.user.telephoneNo = this.restaurant.telephoneNo;
                this.user.address = this.restaurant.address;
                console.log(this.user.ownername);
                await RestaurantDataService.updateARestaurantInformation(this.user)
                    .then(() => {
                        this.isLoading = false;
                        this.retrieveARestaurantInformation();
                        alert("Successfully update");
                    })
                    .catch(err => {
                        this.isLoading = false;
                        console.log(err.message);
                        
                        this.user.RID = this.restaurant.RID = rid;
                        this.user.restaurantname = restaurantname;
                        this.user.ownername = ownername;
                        this.user.restaurantstyle = restaurantstyle;
                        this.user.telephoneNo = telephoneNo;
                        this.user.address = address;

                        this.revertUserInformation();
                        alert("Fail to update");
                    })                
            }
        },
        cancelEditInfo: function () {
            this.revertUserInformation();
            this.readOnlyStatus = true;
        },
        revertUserInformation() {
            if(this.userType == "customer") {
                this.customer.CID = this.user.CID;
                this.customer.custname = this.user.custname;
                this.customer.gender = this.user.gender;
                this.customer.birthdate = this.user.birthdate;
                this.customer.email = this.user.email;
                this.customer.address = this.user.address;

            } else if(this.userType == "restaurant") {
                this.restaurant.RID = this.user.RID;
                this.restaurant.restaurantname = this.user.restaurantname;
                this.restaurant.ownername = this.user.ownername;
                this.restaurant.restaurantstyle = this.user.restaurantstyle;
                this.restaurant.telephoneNo = this.user.telephoneNo;
                this.restaurant.address = this.user.address;
            }
        },
        back: function () {
            if (this.userType.toLowerCase() === "restaurant") {
                this.$router.push('/restaurant');
            } else if (this.userType.toLowerCase() === "customer") {
                this.$router.push('/customer');
            }
        },
        deleteUser: async function () {
            if (this.userType.toLowerCase() === "restaurant") {
                if (window.confirm(`Delete user with id ${this.user.RID}`)) {
                    this.isLoading = true;
                    await RestaurantDataService.deleteARestaurantInformation(this.user.RID)
                        .then(() => {
                            alert("Delete Successfully");
                            this.back();
                        })
                        .catch(err => {
                            alert("Failed to delete");
                            console.log(err.message);
                            this.isLoading = false;
                        })
                }
            } else if (this.userType.toLowerCase() === "customer") {
                if (window.confirm(`Delete user with id ${this.user.CID}`)) {
                    this.isLoading = true;
                    await CustomerDataService.deleteACustomerInformation(this.user.CID)
                        .then(() => {
                            alert("Delete Successfully");
                            this.back();
                        })
                        .catch(err => {
                            alert("Failed to delete");
                            console.log(err.message);
                            this.isLoading = false;
                        })
                }
            }
        }
    }
}
</script>

<style lang="scss">

.user-form-details {
    width: 60%;
    display: block;
    margin-left: auto;
    margin-right: auto;

    h1 {
        text-align: center;
    }

    .button-group {
        text-align: center;
    }

    .btn-delete {
        background-color: rgb(255, 0, 0);
    }

    .btn-save {
        background-color: rgb(0, 128, 0);
    }

    .btn-custom {
        margin: 10px;
    }

    textarea {
        resize: none;
    }
}
</style>
