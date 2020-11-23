<template>
     <div style="font-family:Verdana;color:#aaaaaa;">


      <div style="color: black; padding:15px;text-align:center; background-image: url('../assets/menu/foodpic2.jpg'); background-repeat: no-repeat; background-size: cover;  ">
        <h1>Go Bites</h1>
      </div>

      <div style="overflow:auto">
        <div class="menu">
          <a style = "background-image: url('../assets/menu/nasilemak.jpg'); background-repeat: no-repeat;background-size: 100% 100%" href="#">Breakfast Menu</a>
          <a style = "background-image: url('../assets/menu/nasikerabu.jpg'); background-repeat: no-repeat;background-size: 100% 100%" href="#">Lunch Menu</a>
          <a style = "background-image: url('../assets/menu/hokkienmee.jpg'); background-repeat: no-repeat;background-size: 100% 100%" href="#">Dinner Menu</a>
          <a style = "background-image: url('../assets/menu/tehtarik.jpg'); background-repeat: no-repeat;background-size: 100% 100%" href="#">Teatime Menu</a>
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
      <div style="color: black; background-color:mediumseagreen;text-align:center;padding:10px;margin-top:7px;">© copyright GoBites.com</div>
     </div>
</template>

<style>
* {
  box-sizing: border-box;
  }
.menu {
    float:left;
    width:20%;
    text-align:center;
      }
.menu a {
    background-color:green;
    padding:90px;
    margin-top:10px;
    display:block;
    width:100%;
    color:white;
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
    padding:90px;
    margin-top:7px;
    text-align:center;
    }

@media only screen and (max-width:620px) {
  /* For mobile phones: */
  .menu, .main, .right {width:100%;}
  }

body {
    background-image: url('../assets/menu/foodpic.jpg');
    background-repeat: no-repeat;
    background-attachment: fixed;
    background-size: cover;
      }
</style>
