<template>
<div id="nav">
    <nav class="navbar navbar-expand-md navbar-dark bg-dark">
        <div class="collapse navbar-collapse w-100 order-1 order-md-0 dual-collapse2">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <span class="navbar-brand logo" v-if="!isAuthenticated"><img :src="`${resourceURL}/GoBites-logo.png`" height="30px"></span>
                </li>
                <li class="nav-item">
                    <router-link class="navbar-brand logo" to="/" v-if="isAuthenticated"><img :src="`${resourceURL}/GoBites-logo.png`" height="30px"></router-link>
                </li>

                <li class="nav-item" v-if="isAuthenticated">
                    <div class="dropdown">
                        <button class="btn btn-primary dropdown-toggle top-menu btn-custom" type="button" data-toggle="dropdown">
                            <span class="caret">User</span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-right bg-dark">
                            <li>
                                <router-link class="nav-link" to="/restaurant"><img class="img" :src="`${resourceURL}/icon/icon-restaurant.png`" width="35px" alt="restaurant-icon" /> Restaurant</router-link>
                            </li>

                            <li>
                                <router-link class="nav-link" to="/customer"><img class="img" :src="`${resourceURL}/icon/icon-customer.png`" width="35px" alt="customer-icon" /> Customer</router-link>
                            </li>
                        </ul>

                    </div>
                </li>

                <li class="nav-item" v-if="isAuthenticated">
                    <button class="btn btn-primary btn-custom" type="button" v-if="isAuthenticated">
                        <span class="caret">
                            <router-link class="top-menu" to="/viewMenuList"> Menu List </router-link>
                        </span>
                    </button>
                </li>

                <li class="nav-item" v-if="isAuthenticated">
                    <button class="btn btn-primary btn-custom" type="button">
                        <span class="caret">
                            <router-link class="top-menu" to="/orderList">Order List</router-link>
                        </span>
                    </button>
                </li>

                
                <li class="nav-item" v-if="isAuthenticated">
                    <button class="btn btn-primary btn-custom" type="button">
                        <span class="caret">
                            <router-link class="top-menu" to="/profile">{{ getProfile }}</router-link>
                        </span>
                    </button>
                </li>

                <li class="nav-item" v-if="isAuthenticated" @click="logout">
                    <button class="btn btn-primary top-menu btn-custom" type="button" data-toggle="dropdown">
                        <span class="caret">Logout</span>
                    </button>
                </li>
            </ul>
        </div>
    </nav>
</div>
</template>

<script>
import resourceURL from '../http/resource/http-resource.js';

import {
    mapGetters,
    mapState
} from "vuex";

import {
    AUTH_LOGOUT
} from "../store/actions/auth";

export default {
    name: 'Nav',
    data() {
        return {
            resourceURL,
        }
    },
    methods: {
        async logout() {
            await this.$store.dispatch(AUTH_LOGOUT)
                .then(
                    () => {
                        this.$router.push("/login")
                        console.log("Log out success");
                    }
                );
        },
    },
    computed: {
        ...mapGetters(["getProfile", "isAuthenticated", "isProfileLoaded"]),
        ...mapState({
            authLoading: state => state.auth.status === "loading",
        })
    }
}
</script>

<style lang="scss">
.logout {
    cursor: pointer;
}

.top-menu {
    color: #ffffff;

    &:hover {
        text-decoration: none;
        color: #ffffff;
    }

    &:selected {
        background-color: #ffffff;
    }
}

.nav-link {
    color: #000;
}

.img {
    float: right;
    top: 0;
    right: 0;
}

.btn-custom {
    margin-left: 5px;
    margin-right: 5px;
}
</style>
