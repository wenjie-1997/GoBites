<template>
<div id="home">
    <div class="container">
        <h3>Home Page</h3>
    </div>
</div>
</template>

<script>
export default {
    name: 'Home',
}
</script>

<style lang="scss">
    #home {
        width: 100%;
        height: 100%;

        .container {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            -ms-transform: translate(-50%, -50%);
            /* IE 9 */
            -webkit-transform: translate(-50%, -50%);
            /* Chrome, Safari, Opera */
        }
    }
</style>
