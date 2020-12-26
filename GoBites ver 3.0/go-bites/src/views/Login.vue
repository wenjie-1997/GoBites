<template>
<div id="login">
    <form class="login-form" @submit.prevent="login">
        <loading v-if='isLoading' />
        <div class="form-content form-custom" v-if="admin">
            <h3>Login</h3>

            <div class="form-group">
                <input type="text" id="userName" v-model="username" class="form-control" placeholder="Username" required />
            </div>

            <div class="form-group">
                <input type="password" id="userPassword" v-model="password" class="form-control" placeholder="Password" autocomplete="off" required />
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
            message: "Either password or username is invalid",
            isLoading: false,
            admin: null,
        }
    },
    methods: {
        async getAdminInformation() {
            const type = "admin";
            await UserDataService.getAllUsersOfSameType(type)
                .then((response) => {
                    this.isLoading = false;
                    this.admin = response.data[0];
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
        this.isLoading = true;
        this.getAdminInformation();
    }
}
</script>

<style lang="scss">
#login {
    .login-form {
        min-width: 150px;
        max-width: 450px;
        display: block;
        margin-left: auto;
        margin-right: auto;

        .form-custom {
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: rgba(184, 20, 20, 0);
            border: 10px inset rgb(117, 207, 235);
            padding: 10px 10px 10px 10px;
            box-shadow: inset 0 0 10px;
            transition: 0.2s;

            .form-control {
                border-radius: 24px;
                box-shadow: 10px 5px 5px rgb(76, 194, 214);

                &:focus {
                    border-color: #167bff;
                    box-shadow: none;
                }
            }

            .login-btn {
                display: flex;
                flex-direction: column;
                align-items: center;

                button {
                    border-radius: 24px;
                    width: 100px;

                    &:hover {
                        border-color: #167bff;
                        box-shadow: 10px 5px 5px rgb(76, 194, 214);
                    }
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
}

</style>
