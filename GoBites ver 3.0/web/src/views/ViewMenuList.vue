<template>
     <div id="menuList">
        <div class="menu-list">
          <h1>GoBites</h1>
        </div>

        <div class="menu-list-container">
            <div class="row">
              <div class="col breakfast-menu">
                <router-link class="link-menu" to="/breakfastMenu">Breakfast Menu</router-link>
              </div>
              <div class="col lunch-menu">
                  <router-link class="link-menu" to="/lunchMenu">Lunch Menu</router-link>
              </div>
            </div>
            <div class="row">
              <div class="col dinner-menu">
                  <router-link class="link-menu" to="/dinnerMenu">Dinner Menu</router-link>
              </div>
              <div class="col tea-time-menu">
                  <router-link class="link-menu" to="/teatimeMenu">Teatime Menu</router-link>
              </div>
            </div>
        </div>
     </div>
</template>

<script>
import resourceURL from '../http/resource/http-resource.js';

export default {
  name: 'MenuList',
  data() {
    return {
      imageUrl : resourceURL + '/menu/',
    }
  },
}
</script>

<style lang="scss" scoped>
@import '../style/imageURL.scss';

#menuList {
    width: 90%;
    display: block;
    margin-left: auto;
    margin-right: auto;

    font-family:Verdana;
    color:#aaaaaa;
  
    box-sizing: border-box;
  
    margin-top: 1%;
    margin-bottom: 1%;

    box-shadow:
        0 2.8px 2.2px rgba(0, 0, 0, 0.034),
        0 6.7px 5.3px rgba(0, 0, 0, 0.048),
        0 12.5px 10px rgba(0, 0, 0, 0.06),
        0 22.3px 17.9px rgba(0, 0, 0, 0.072),
        0 41.8px 33.4px rgba(0, 0, 0, 0.086),
        0 100px 80px rgba(0, 0, 0, 0.12);

    .menu-list {
        color: black; 
        padding:15px;
        text-align:center; 
        background-image: url($foodpic2-image-url); 
        background-repeat: no-repeat; 
        background-size: cover; 
    }

    .menu-list-container {
        padding-top: 1%;
        padding-bottom: 1%;

        .breakfast-menu,
        .lunch-menu,
        .dinner-menu,
        .tea-time-menu {
            background-color:green;
            height: 300px;
            padding: 80px;
            border-radius: 24px;
            margin: 3% 12% 3% 12%;
            box-shadow:
                0 2.8px 2.2px rgba(0, 0, 0, 0.034),
                0 6.7px 5.3px rgba(0, 0, 0, 0.048),
                0 12.5px 10px rgba(0, 0, 0, 0.06),
                0 22.3px 17.9px rgba(0, 0, 0, 0.072),
                0 41.8px 33.4px rgba(0, 0, 0, 0.086),
                0 100px 80px rgba(0, 0, 0, 0.12);

            

            .link-menu {
              background-color: rgba(255, 255, 255, 0.933);
              opacity: 0.6;
              color:rgb(0, 0, 0);
              border-radius: 24px;
              outline: none;
              padding: 2%;
              box-shadow:
                0 2.8px 2.2px rgba(0, 0, 0, 0.4),
                0 6.7px 5.3px rgba(0, 0, 0, 0.4),
                0 12.5px 10px rgba(0, 0, 0, 0.06),
                0 22.3px 17.9px rgba(0, 0, 0, 0.072),
                0 41.8px 33.4px rgba(0, 0, 0, 0.086),
                0 100px 80px rgba(0, 0, 0, 0.12);
              
              transition: 0.2s;

              &:hover {
                color: rgb(0, 0, 0);
                opacity: 1;
                font-size: 110%;
                text-decoration: none;
                background-color: rgba(105, 190, 201, 0.933);
                transition: 0.2s;
              }
            }

            &:hover {
              opacity: 0.9;
            }
        }
        
        .breakfast-menu {
          background-image: url($breakfast-image-url); 
          background-repeat: no-repeat;
          background-size: 100% 100%;
        }

        .lunch-menu {
          background-image: url($lunch-image-url); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

        .dinner-menu {
          background-image: url($dinner-image-url); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

        .tea-time-menu {
          background-image: url($teatime-image-url); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

    }
}
</style>
