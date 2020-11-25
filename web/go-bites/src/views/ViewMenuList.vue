<template>
     <div id="menuList">
        <div class="menu-list">
          <h1>Go Bites</h1>
        </div>

        <div class="menu-list-container">
            <div class="row">
                <router-link class="col-md-2 breakfast-menu" to="/breakfastMenu">Breakfast Menu</router-link>
            </div>
            <div class="row">
                <router-link class="col-md-2 lunch-menu" to="/lunchMenu">Lunch Menu</router-link>
            </div>
            <div class="row">
                <router-link class="col-md-2 dinner-menu" to="/dinnerMenu">Dinner Menu</router-link>
            </div>
            <div class="row">
                <router-link class="col-md-2 tea-time-menu" to="/teatimeMenu">Teatime Menu</router-link>
            </div>
        </div>
     </div>
</template>

<script>
export default {
  name: 'MenuList',
}
</script>

<style lang="scss">
#menuList {
    display: flex;
    flex-direction: column;

    font-family:Verdana;
    color:#aaaaaa;
  
    box-sizing: border-box;
  
    margin-top: 2%;
    margin-bottom: 3%;

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
        background-image: url('../assets/menu/foodpic2.jpg'); 
        background-repeat: no-repeat; 
        background-size: cover; 
    }

    .menu-list-container {
        padding-left: 10px;
        padding-right: 10px;

        .breakfast-menu,
        .lunch-menu,
        .dinner-menu,
        .tea-time-menu {
            background-color:green;
            padding:90px;
            margin-top:10px;
            margin-bottom:10px;
            float:left;
            width:100%;
            color:white;
            border-radius: 24px;
            margin-left: 10px;
            box-shadow:
                0 2.8px 2.2px rgba(0, 0, 0, 0.034),
                0 6.7px 5.3px rgba(0, 0, 0, 0.048),
                0 12.5px 10px rgba(0, 0, 0, 0.06),
                0 22.3px 17.9px rgba(0, 0, 0, 0.072),
                0 41.8px 33.4px rgba(0, 0, 0, 0.086),
                0 100px 80px rgba(0, 0, 0, 0.12);

            &:hover {
              opacity: 0.9;
            }
        }
        
        .breakfast-menu {
          background-image: url('../assets/menu/nasilemak.jpg'); 
          background-repeat: no-repeat;
          background-size: 100% 100%;
        }

        .lunch-menu {
          background-image: url('../assets/menu/nasikerabu.jpg'); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

        .dinner-menu {
          background-image: url('../assets/menu/hokkienmee.jpg'); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

        .tea-time-menu {
          background-image: url('../assets/menu/tehtarik.jpg'); 
          background-repeat: no-repeat;
          background-size: 100% 100%
        }

    }
}
</style>
