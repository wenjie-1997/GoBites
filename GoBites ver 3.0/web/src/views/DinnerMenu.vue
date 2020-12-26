<template>
     <div id="dinner">
      <div class="jumbotron">
        <h1 class="display-4" >Dinner</h1>
        <hr class="my-4">

        <loading v-if='isLoading' />
        <div v-if="!isLoading">
          <MenuItem :menuItems="menuItems" />
        </div>
      </div>
    </div>
</template>

<script>
import MenuItem from '../components/MenuItem.vue';
import MenuItemDataService from '../services/MenuItemDataService.js';
import loading from '../mixins/loading.vue';

export default {
  name: 'Dinner',
  components: {
    MenuItem,
    loading,
  },
  data() {
    return {
      menuItems: [],
      isLoading: false,
      startIndex: 10,
      endIndex: 15
    }
  },
  methods: {
    async getAllMenuItems() {
      MenuItemDataService.getAllMenuItems()
        .then(resp => {
          if(Object.keys(resp.data).length > this.startIndex) {
            for(var i = this.startIndex; i < this.endIndex && i < Object.keys(resp.data).length; i++) {
              this.menuItems.push(resp.data[i]);
            }
          }
          
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

#dinner {
    width: 95%;
    display: block;
    margin-left: auto;
    margin-right: auto;

  h1 {
    font-family: 'Vibur', cursive;
  }
}
</style>
