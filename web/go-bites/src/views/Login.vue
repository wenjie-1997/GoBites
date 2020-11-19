<template>
<div id="login">
    <form class="login-form" method="post" @submit.prevent="login">
        <div class="form-content">
            <loading v-if='isLoading' :is-full-page="fullPage" :loader='loader' />
            <h3>Login</h3>

            <div class="form-group">
                <label>username</label>
                <input type="text" v-model="username" class="form-control" placeholder="Username" required />
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" v-model="password" class="form-control" placeholder="Password" autocomplete="off" required />
            </div>

            <div class="login-btn">
                <button type="submit" class="btn btn-primary btn-block" :disabled="isLoading">Login</button>
            </div>
        </div>

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
import UserDataService from "../services/UserDataService";

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
            loader: 'bars',
            admin: null,
        }
    },
    methods: {
        async getAdminInformation() {
            const type = "admin";
            const id = 1;
            await UserDataService.getAllUsersOfSameType(type, id)
                .then((response) => {
                    this.admin = response.data;
                    this.admin = this.admin[0];
                })
                .catch((e) => {
                    console.log(e);
                });
        },
        login: function () {
            if(this.admin === null) {
                alert("Error! Check your database connection");
                return;
            }

            this.isLoading = true;
            const {
                username,
                password,
                admin
            } = this;

            this.$store.dispatch(AUTH_REQUEST, {
                    username,
                    password,
                    admin
                })
                .then(
                    () => {
                        this.isLoading = false;
                        alert("Login Success");
                        this.$router.push("/");
                    }
                );

            if (this.loginStatus === "fail") {
                this.isLoading = false;
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
    },
    mounted() {
        this.getAdminInformation();
    }
}
</script>

<style lang="scss" scoped>
.login-form {
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

        &:hover {
            border: 10px outset rgb(117, 207, 235);
            padding: 10px 10px 10px 10px;
            box-shadow: 5px 5px 10px;
            transition: 0.2s;
        }
    }
}
</style>
