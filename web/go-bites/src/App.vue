<template>
<div id="app">
    <nav>
        <router-link to="/" class="router_link">
            <div class="navigation_logo">
                GoBites
            </div>
        </router-link>
        <router-link to="/restaurant" class="router_link">Restaurant</router-link>
        <router-link to="/login" class="router_link">Login</router-link>
    </nav>
    <router-view />
</div>
</template>

<script>
export default {
    name: 'App',
    setup() {

    },
}
</script>

<style lang="scss">
@import './styles/base.scss';

#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    min-height: 100vh;
    background-color: #F3F5FA;

    nav {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 10px 5%;
        background-color: rgba(77, 64, 192, 0.767);
        color: white;

        .router_link {
            color: inherit;
            text-decoration: none;
        }

        .navigation_logo {
            font-weight: bold;
            font-size: 24px;
        }
    }
}
</style>
