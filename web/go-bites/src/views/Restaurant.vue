<template>
<div id="restaurant">
    <h1>Restaurant</h1>
    <div class="restaurant_list">
        <h3 v-for="restaurant in restaurants" :key="restaurant.id">
            {{ restaurant.name }}
        </h3>
    </div>
</div>
</template>

<script>
import {
    restaurants
} from "../assets/restaurants.js";

export default {
    name: 'Restaurant',
    setup() {
        return {
            restaurants,
        }
    }
}
</script>

<style lang="scss" scoped>
#restaurant {
    padding: 50px 5%;

    .restaurant_list {
        display: flex;
        flex-direction: column;
    }
}
</style>
