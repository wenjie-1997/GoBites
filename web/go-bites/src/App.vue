<template>
<div id="app">
    <Nav />
    <div class="auth-wrapper">
        <div class="auth-inner">
            <router-view />
        </div>
    </div>
</div>
</template>

<script>
import Nav from './components/Nav.vue'

import {
    USER_REQUEST
} from "./store/actions/user";

export default {
    name: 'App',
    components: {
        Nav,
    },
    created: function () {
        if (this.$store.getters.isAuthenticated) {
            this.$store.dispatch(USER_REQUEST);
        }
    }
}
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css?family=Fira+Sans:400,500,600,700,800');

* {
    box-sizing: border-box;
}

body {
    background: #1C8EF9 !important;
    min-height: 100vh;
    display: flex;
    font-weight: 400;
    font-family: 'Fira Sans', sans-serif;
}

#app {
    text-align: center;
}

h1,
h2,
h3,
h4,
h5,
h6,
label,
span {
    font-weight: 500;
    font-family: 'Fira Sans', sans-serif;
}

body,
html,
#app,
#root,
.auth-wrapper {
    width: 100%;
    height: 100%;
}

.navbar-light {
    background-color: #ffffff;
    box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);
}

.auth-wrapper {
    display: flex;
    justify-content: center;
    flex-direction: column;
    text-align: left;

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

    h3 {
        text-align: center;
        margin: 0;
        line-height: 1;
        padding-bottom: 20px;
    }
}

.auth-inner {
    width: 450px;
    margin: auto;
    background: #ffffff;
    box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);
    padding: 40px 55px 45px 55px;
}

.custom-control-label {
    font-weight: 400;
}
</style>
