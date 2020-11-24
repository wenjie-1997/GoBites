<template>
<div id="app" class="d-flex flex-column min-vh-100">
    <header>
        <Nav />
    </header>

    <content>
        <div class="auth-wrapper">
            <div class="auth-inner">
                <router-view />
            </div>
        </div>
    </content>

    <footer class="mt-auto">
        <Footer />
    </footer>
</div>
</template>

<script>
import Nav from './components/Nav.vue'
import Footer from './components/Footer.vue'

import {
    ADMIN_REQUEST
} from "./store/actions/admin";

export default {
    name: 'App',
    components: {
        Nav,
        Footer,
    },
    created: function () {
        if (this.$store.getters.isAuthenticated) {
            this.$store.dispatch(ADMIN_REQUEST);
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
    min-height: 100vh;
    min-width: 100%;
    display: flex;
    justify-content: center;
    flex-direction: column;
    text-align: left;

    h3 {
        text-align: center;
        margin: 0;
        line-height: 1;
        padding-bottom: 20px;
    }
}

.auth-inner {
    width: 99%;
    height: 99%;
    margin: auto;
    background: #ffffff;
    box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);
    padding: 40px 55px 45px 55px;
    border-radius: 5px;
}

.custom-control-label {
    font-weight: 400;
}
</style>
