<template>
<div id="user-details">
    <div class="user-form-details" v-if="userExist && userId!='-1'">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <div class="customer-details" v-if="user">
            <h1>User Info</h1>
            <form action="#" v-if="userType == 'customer'">
                <div class="form-content" v-if='!isLoading'>
                    <div  class="form-group">
                        <label>Customer Id</label>
                        <input type="number" v-model="user.CID" readonly />
                    </div>

                    <div  class="form-group">
                        <label>Customer Name</label>
                        <input type="text" v-model="customer.custname" :readonly="readOnlyStatus" required />
                    </div>
                    
                    <div class="form-group">
                        <label>Birth Date (YYYY-MM-DD)</label>
                        <input type="text" v-model="customer.birthdate" :readonly="readOnlyStatus" required />
                    </div>

                    <div class="form-group">
                        <label>Gender</label>
                        <label>Male <input type="radio" value="Male" v-model="customer.gender" :disabled="readOnlyStatus" /></label>
                        <label>Female <input type="radio" value="Female" v-model="customer.gender" :disabled="readOnlyStatus" /></label>
                    </div>

                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" v-model="customer.email" :readonly="readOnlyStatus" required />
                    </div>

                    <div class="form-group">
                        <label>Address</label>
                        <textarea rows="3" type="text" v-model="customer.address" :readonly="readOnlyStatus" required />
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
            <form action="#" v-if="userType == 'restaurant'">
                <div class="form-content" v-if='!isLoading'>
                    <div  class="form-group">
                        <label>Restaurant Id</label>
                        <input type="number" v-model="restaurant.RID" readonly />
                    </div>

                    <div  class="form-group">
                        <label>Restaurant Name</label>
                        <input type="text" v-model="restaurant.restaurantname" :readonly="readOnlyStatus" required />
                    </div>

                    <div  class="form-group">
                        <label>Owner Name</label>
                        <input type="text" v-model="restaurant.ownername" :readonly="readOnlyStatus" required />
                    </div>

                    <div  class="form-group">
                        <label>Restaurant Style</label>
                        <input type="text" v-model="restaurant.restaurantstyle" :readonly="readOnlyStatus" required />
                    </div>

                    <div  class="form-group">
                        <label>Address</label>
                        <textarea rows="3" type="text" v-model="restaurant.address" :readonly="readOnlyStatus" required />
                    </div>

                    <div  class="form-group">
                        <label>Telephone No</label>
                        <input type="text" v-model="restaurant.telephoneNo" :readonly="readOnlyStatus" required />
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

            customer: {
                CID: '',
                custname: '',
                birthdate: '',
                gender: '',
                email: '',
                address: '',
            },

            restaurant: {
                RID: '',
                restaurantname: '',
                ownername: '',
                address: '',
                restaurantstyle: '',
                telephoneNo: '',
            },
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

                    this.customer.CID = this.user.CID;
                    this.customer.custname = this.user.custname;
                    this.customer.gender = this.user.gender;
                    this.customer.birthdate = this.user.birthdate;
                    this.customer.email = this.user.email;
                    this.customer.address = this.user.address;
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

                    this.restaurant.RID = this.user.RID;
                    this.restaurant.restaurantname = this.user.restaurantname;
                    this.restaurant.ownername = this.user.ownername;
                    this.restaurant.restaurantstyle = this.user.restaurantstyle;
                    this.restaurant.telephoneNo = this.user.telephoneNo;
                    this.restaurant.address = this.user.address;
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
                    await RestaurantDataService.deleteARestaurantInformation(this.user)
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
                    await CustomerDataService.deleteACustomerInformation(this.user)
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
.customer-details,
.restaurant-details{
    text-align: center;
}

.user-form-details {
    width: 70%;
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

            input, textarea {
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

            input[type=radio] {
                margin-right: 40px;
                border: 1px solid black;
            }

            textarea {
                resize: none;
            }

            label {
                text-align: left;
                margin-left: 0;
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
