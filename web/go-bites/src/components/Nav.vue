<template>
<div id="nav">
    <nav class="navbar navbar-expand navbar-dark bg-dark fixed-top">
        <div class="container">
            <span class="navbar-brand logo" v-if="!isAuthenticated">GoBites</span>
            <router-link class="navbar-brand logo" to="/" v-if="isAuthenticated">GoBites</router-link>
            <button class="btn btn-primary" type="button" v-if="isAuthenticated && isProfileLoaded">
                <span class="caret">
                    <router-link class="top-menu" to="/profile">{{ getProfile }}</router-link>
                </span>
            </button>

            <button class="btn btn-primary" type="button" v-if="isAuthenticated">
                <span class="caret">
                    <router-link class="top-menu" to="/viewMenuList"> Menu List </router-link>
                </span>
            </button>

            <button class="btn btn-primary" type="button" v-if="isAuthenticated">
                <span class="caret">
                    <router-link class="top-menu" to="/restaurantList"> Restaurant List </router-link>
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
                                    <router-link class="nav-link" to="/restaurant"><img class="img" src="../assets/icon/icon-restaurant.png" width="35px" alt="restaurant-icon" /> Restaurant</router-link>
                                </li>

                                <li>
                                    <router-link class="nav-link" to="/customer"><img class="img" src="../assets/icon/icon-customer.png" width="35px" alt="customer-icon" /> Customer</router-link>
                                </li>
                            </ul>

                        </div>
                    </li>

                    <li class="nav-item" v-if="isAuthenticated" @click="logout">
                        <button class="btn btn-primary top-menu" type="button" data-toggle="dropdown">
                            <span class="caret">Logout</span>
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
@import url(https://fonts.googleapis.com/css?family=Vibur);

.logout {
    cursor: pointer;
}

.logo {
    font-family: 'Vibur', cursive;
    font-size: 28px;
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
</style>
