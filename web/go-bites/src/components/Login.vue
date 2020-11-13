<template>
<div id="login">
    <form class="login-form" method="post" @submit.prevent="login">
        <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
        <h3>Login</h3>

        <div class="form-group">
            <label>username</label>
            <input type="text" v-model="username" class="form-control" placeholder="Email" />
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" v-model="password" class="form-control" placeholder="Password" autocomplete="off" />
        </div>

        <button type="submit" class="btn btn-primary btn-block">Login</button>
    </form>
</div>
</template>

<script>
import {
    AUTH_REQUEST
} from "../store/actions/auth";

import {
    mapState
} from 'vuex';

import loading from '../mixins/loading.vue'

export default {
    name: 'Login',
    components: {
        loading
    },
    data() {
        return {
            username: '',
            password: '',
            message: "Either password or username is invalid \nHint: \n    username: admin \n    password: 1234",
            isLoading: false,
            fullPage: false,
            loader: 'bars'
        }
    },
    methods: {
        login: function () {
            this.isLoading = true;

            const {
                username,
                password
            } = this;

            this.$store.dispatch(AUTH_REQUEST, {
                    username,
                    password
                })
                .then(
                    () => {
                        this.$router.push("/");
                    }
                );

            if (this.loginStatus === "fail") {
                alert(this.message);
                this.username = '';
                this.password = '';
                return;
            }

        }
    },
    computed: {
        ...mapState({
            loginStatus: state => state.auth.status
        })
    }
}
</script>
