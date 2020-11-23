<template>
     <div id="menuList">
        <div class="menu-list">
          <h1>Go Bites</h1>
        </div>

        <div class="menu-list-container">
            <div class="menu">
                <router-link class="breakfast-menu" to="/breakfastMenu">Breakfast Menu</router-link>
                <router-link class="lunch-menu" to="/lunchMenu">Lunch Menu</router-link>
                <router-link class="dinner-menu" to="/dinnerMenu">Dinner Menu</router-link>
                <router-link class="tea-time-menu" to="/teatimeMenu">Teatime Menu</router-link>
            </div>

            <div class="main">
              <h2>New User Promotion!!!</h2>
                <p>All new user that register to the app will get 20% discount of their first purchase!!!</p>
            </div>

            <div class="right">
              <h2>About GoBites</h2>
              <p>GoBites Malaysia started with one goal in mind: to be the most convenient food delivery service in the country. Using the easy smartphone app, anyone can find their favorite restaurants near you and order their favorite dish, or even snacks, beverages and more. Whether it is breakfast delivery, lunch or dinner delivery, GoBites is your ultimate place to order food from any kind of restaurant and shops anywhere in Malaysia. We believe food is a pleasure and food ordering should be a fast and fun experience.
              ✓ More cities: GoBites is available in Kuala Lumpur, Petaling Jaya, Penang and in many more Malaysian cities.
              ✓ More restaurants: Enjoy food delivery from over 100 restaurants in Malaysia.
              ✓ More cuisines: With a wide range of cuisines, one can order fast food, pizza delivery, drinks, desserts, cake or daily items.
              ✓ More than just food delivery: Wake up to the smell of freshly brewed coffee & drinks from your favorite cafes at your home.</p>
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
    font-family:Verdana;
    color:#aaaaaa;
    height: 100%;
    width: 100%;
    
    background-image: url('../assets/menu/foodpic.jpg');
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
    box-sizing: border-box;
    

    .menu-list {
        color: black; 
        padding:15px;
        text-align:center; 
        background-image: url('../assets/menu/foodpic2.jpg'); 
        background-repeat: no-repeat; 
        background-size: cover; 
    }

    .menu-list-container {
        overflow: auto;

        .menu {
            float:left;
            width:20%;
            text-align:center;

            .breakfast-menu,
            .lunch-menu,
            .dinner-menu,
            .tea-time-menu {
                background-color:green;
                padding:90px;
                margin-top:10px;
                display:block;
                width:100%;
                color:white;
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

        .main {
            color: white;
            float:left;
            width:60%;
            padding:0 20px;
        }

        .right {
            color: black;
            background-color:green;
            float:left;
            width:20%;
            height: 100%;
            padding:90px;
            margin-top:7px;
            text-align:center;
        }

        @media only screen and (max-width:620px) {
          /* For mobile phones: */
          .menu, .main, .right {width:100%;}
        }
    }
}
</style>
