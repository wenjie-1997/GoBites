<template>
<div id="nav">
    <nav class="navbar navbar-expand navbar-light fixed-top">
        <div class="container">
            <span class="logo" v-if="!isAuthenticated">GoBites</span>
            <router-link class="navbar-brand logo" to="/" v-if="isAuthenticated">GoBites</router-link>
            <span v-if="isProfileLoaded" class="nav-link logout">{{ name }}</span>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item" v-if="isAuthenticated">
                        <router-link class="nav-link" to="/restaurant">Restaurant</router-link>
                    </li>

                    <li class="nav-item" v-if="isAuthenticated" @click="logout">
                        <span class="nav-link logout">Logout</span>
                    </li>

                    <li class="nav-item" v-if="!isAuthenticated && !authLoading">
                        <router-link class="nav-link" to="/login">Login</router-link>
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
            name: state => `${state.user.profile.title} ${state.user.profile.name}`
        })
    }
}
</script>

<style>
@import url(https://fonts.googleapis.com/css?family=Vibur);

.logout {
    cursor: pointer;
}

.logo {
    font-family: 'Vibur', cursive;
    font-size: 30px;
}
</style>
