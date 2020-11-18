<template>
<div id="nav">
    <nav class="navbar navbar-expand navbar-dark bg-dark fixed-top">
        <div class="container">
            <span class="navbar-brand logo" v-if="!isAuthenticated">GoBites</span>
            <router-link class="navbar-brand logo" to="/" v-if="isAuthenticated">GoBites</router-link>
            <button class="btn btn-primary" type="button" v-if="isAuthenticated">
                <span class="caret">
                    <router-link class="top-menu" to="/profile" v-if="isProfileLoaded">{{ name }}</router-link>
                </span>
            </button>

            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item" v-if="isAuthenticated">
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle top-menu" type="button" data-toggle="dropdown">
                                <span class="caret">User</span>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-right bg-dark">
                                <li>
                                    <a href="#">
                                        <span>
                                            <router-link class="nav-link" to="/restaurant"><img class="img" src="../assets/icon/icon-restaurant.png" width="35px" alt="restaurant-icon" /> Restaurant</router-link>
                                        </span>
                                    </a>
                                </li>

                                <li>
                                    <a href="#">
                                        <span>
                                            <router-link class="nav-link" to="/customer"><img class="img" src="../assets/icon/icon-customer.png" width="35px" alt="customer-icon" /> Customer</router-link>
                                        </span>
                                    </a>
                                </li>

                                <li>
                                    <a href="#">
                                        <span>
                                            <router-link class="nav-link" to="/deliveryDriver"><img class="img" src="../assets/icon/icon-delivery.png" width="35px" alt="customer-icon" /> Delivery Driver</router-link>
                                        </span>
                                    </a>
                                </li>
                            </ul>

                        </div>
                    </li>

                    <li class="nav-item" v-if="isAuthenticated" @click="logout">
                        <button class="btn btn-primary top-menu" type="button" data-toggle="dropdown">
                            <span class="caret">Logout</span>
                        </button>
                    </li>

                    <li class="nav-item" v-if="!isAuthenticated && !authLoading">
                        <button class="btn btn-primary" type="button" data-toggle="dropdown">
                            <span class="caret">
                                <router-link class="top-menu" to="/login">Login</router-link>
                            </span>
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

</div>
</template>

<script>
import {
    mapGetters,
    mapState
} from "vuex";

import {
    AUTH_LOGOUT
} from "../store/actions/auth";

export default {
    name: 'Nav',
    methods: {
        logout: function () {
            this.$store.dispatch(AUTH_LOGOUT)
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
            name: state => `${state.admin.profile.title} ${state.admin.profile.name}`
        })
    }
}
</script>

<style lang="scss">
@import url(https://fonts.googleapis.com/css?family=Vibur);

.logout {
    cursor: pointer;
}

.logo {
    font-family: 'Vibur', cursive;
    font-size: 28px;
}

.top-menu {
    color: #ddcfcf;

    &:hover {
        color: #ffffff;
        text-decoration: none;
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
</style>
