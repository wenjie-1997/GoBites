<template>
     <div id="lunch">
      <div class="jumbotron">
        <h1 class="display-4" >Lunch</h1>
        <hr class="my-4">

        <loading v-if='isLoading' />
        <MenuItem v-if="menuItems" :menuItems="menuItems" :startIndex="startIndex" :endIndex="endIndex" />
      </div>
    </div>
</template>

<script>
import MenuItem from '../components/MenuItem.vue';
import MenuItemDataService from '../services/MenuItemDataService.js';
import loading from '../mixins/loading.vue';

export default {
  name: 'Lunch',
  components: {
    MenuItem,
    loading,
  },
  data() {
    return {
      menuItems: null,
      isLoading: false,
      startIndex: 5,
      endIndex: 10
    }
  },
  methods: {
    async getAllMenuItems() {
      MenuItemDataService.getAllMenuItems()
        .then(resp => {
          this.menuItems = resp.data;
          this.isLoading = false;
        })
        .catch(err => {
          console.log(err.message);
        })
    }
  },
  mounted() {
    this.isLoading = true;
    this.getAllMenuItems();
  }
}
</script>

<style lang="scss" scoped>
@import url(https://fonts.googleapis.com/css?family=Vibur);

#lunch {
  margin-top: 2%;
  margin-bottom: 1%;
  padding-bottom: 20px;

  h1 {
    font-family: 'Vibur', cursive;
  }
}
</style>
