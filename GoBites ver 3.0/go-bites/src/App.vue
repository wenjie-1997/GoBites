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

    <footer>
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
    },
}
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css?family=Fira+Sans:400,500,600,700,800');
@import './style/globalStyle.scss';

* {
    box-sizing: border-box;
}

body {
    background: #1C8EF9 !important;
    display: flex;
    font-weight: 400;
    font-family: 'Fira Sans', sans-serif;
}

#app {
    text-align: center;
}

body,
html,
#app,
#root,
.auth-wrapper {
    width: 100%;
    height: 100%;
}

.auth-wrapper {
    min-height: 80vh;
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
    border-radius: 5px;
    padding-top: 50px;
    padding-bottom: 50px;
}
</style>
