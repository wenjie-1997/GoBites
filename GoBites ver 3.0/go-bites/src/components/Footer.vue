<template>
<div id="footer">
    <footer id="footer" class="footer-1">
        <div class="main-footer widgets-dark typo-light">
            <div class="container">

                <div class="widget subscribe no-box">
                    <h5 class="widget-title"><img :src="`${resourceURL}/GoBites-logo-website.png`" width="54px" height="54px">GoBites<span></span></h5>
                    <p> GoBites Malaysia started with one goal in mind: to be the most convenient food delivery service in the country. Using the easy smartphone app, anyone can find their favorite restaurants near you and order their favorite dish, or even snacks, beverages and more. Whether it is breakfast delivery, lunch or dinner delivery, GoBites is your ultimate place to order food from any kind of restaurant and shops anywhere in Malaysia. We believe food is a pleasure and food ordering should be a fast and fun experience.</p>
                    <hr>
                </div>

                <div class="row">
                    <div class="col-xs-12 col-sm-6 col-md-3">
                        <div class="widget subscribe no-box">
                            <h5 class="widget-title">✓ More cities<span></span></h5>
                            <p> GoBites is available in Kuala Lumpur, Petaling Jaya, Penang and in many more Malaysian cities.</p>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6 col-md-3">
                        <div class="widget subscribe no-box">
                            <h5 class="widget-title">✓ More restaurants<span></span></h5>
                            <p> Enjoy food delivery from over 100 restaurants in Malaysia.</p>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6 col-md-3">
                        <div class="widget subscribe no-box">
                            <h5 class="widget-title">✓ More cuisines<span></span></h5>
                            <p> With a wide range of cuisines, one can order fast food, pizza delivery, drinks, desserts, cake or daily items.</p>
                        </div>
                    </div>

                    <div class="col-xs-12 col-sm-6 col-md-3">
                        <div class="widget subscribe no-box">
                            <h5 class="widget-title">✓ Not just food delivery<span></span></h5>
                            <p> Wake up to the smell of freshly brewed coffee & drinks from your favorite cafes at your home.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="footer-copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p>Copyright GoBites © 2020. All rights reserved.</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>
</template>

<script>
import resourceURL from '../http/resource/http-resource.js';

export default {
    name: 'Footer',
    data() {
        return {
            resourceURL,
        }
    },
}
</script>

<style lang="scss">
/* Main Footer */
footer .main-footer {
    padding: 20px 0;
    background: #252525;
}

/* Copy Right Footer */
.footer-copyright {
    background: #222;
    padding: 5px 0;
}

.footer-copyright p {
    color: #969696;
    margin: 2px 0 0;
}

/*==================== 
Widgets 
====================== */
.widget {
    padding: 20px;
    margin-bottom: 40px;
}

.widget.no-box {
    padding: 0;
    background-color: transparent;
    margin-bottom: 40px;
    box-shadow: none;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    -ms-box-shadow: none;
    -o-box-shadow: none;
}

.widget-title {
    margin-bottom: 20px;
}

.widget-title span {
    background: #839FAD none repeat scroll 0 0;
    display: block;
    height: 1px;
    margin-top: 25px;
    position: relative;
    width: 70%;
}

.widget-title span::after {
    background: inherit;
    content: "";
    height: inherit;
    position: absolute;
    top: -4px;
    width: 50%;
}

.widget-title.text-center span,
.widget-title.text-center span::after {
    margin-left: auto;
    margin-right: auto;
    left: 0;
    right: 0;
}

.typo-light h5,
.typo-light p {
    color: #fff;
}
</style>
