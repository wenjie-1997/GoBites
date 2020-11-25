<template>
<div id="footer">
    <footer id="footer" class="footer-1">
        <div class="main-footer widgets-dark typo-light">
            <div class="container">

                <div class="widget subscribe no-box">
                    <h5 class="widget-title">GoBites<span></span></h5>
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
export default {
    name: 'Footer',
}
</script>

<style lang="scss">
/* Main Footer */
footer .main-footer {
    margin-top: -3.5%;
    padding: 20px 0;
    background: #252525;
}

footer ul {
    padding-left: 0;
    list-style: none;
}

/* Copy Right Footer */
.footer-copyright {
    background: #222;
    padding: 5px 0;
}

.footer-copyright .logo {
    display: inherit;
}

.footer-copyright nav {
    float: right;
    margin-top: 5px;
}

.footer-copyright nav ul {
    list-style: none;
    margin: 0;
    padding: 0;
}

.footer-copyright nav ul li {
    border-left: 1px solid #505050;
    display: inline-block;
    line-height: 12px;
    margin: 0;
    padding: 0 8px;
}

.footer-copyright nav ul li a {
    color: #969696;
}

.footer-copyright nav ul li:first-child {
    border: medium none;
    padding-left: 0;
}

.footer-copyright p {
    color: #969696;
    margin: 2px 0 0;
}

/* Footer Top */
.footer-top {
    background: #252525;
    padding-bottom: 30px;
    margin-bottom: 30px;
    border-bottom: 3px solid #222;
}

/* Footer transparent */
footer.transparent .footer-top,
footer.transparent .main-footer {
    background: transparent;
}

footer.transparent .footer-copyright {
    background: none repeat scroll 0 0 rgba(0, 0, 0, 0.3);
}

/* Footer light */
footer.light .footer-top {
    background: #f9f9f9;
}

footer.light .main-footer {
    background: #f9f9f9;
}

footer.light .footer-copyright {
    background: none repeat scroll 0 0 rgba(255, 255, 255, 0.3);
}

/* Footer 4 */
.footer- .logo {
    display: inline-block;
}

/*==================== 
Widgets 
====================== */
.widget {
    padding: 20px;
    margin-bottom: 40px;
}

.widget.widget-last {
    margin-bottom: 0px;
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

.widget.subscribe p {
    margin-bottom: 18px;
}

.widget li a {
    color: #ff8d1e;
}

.widget li a:hover {
    color: #4b92dc;
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
    width: 20%;
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

.widget .badge {
    float: right;
    background: #7f7f7f;
}

.typo-light h1,
.typo-light h2,
.typo-light h3,
.typo-light h4,
.typo-light h5,
.typo-light h6,
.typo-light p,
.typo-light div,
.typo-light span,
.typo-light small {
    color: #fff;
}

ul.social-footer2 {
    margin: 0;
    padding: 0;
    width: auto;
}

ul.social-footer2 li {
    display: inline-block;
    padding: 0;
}

ul.social-footer2 li a:hover {
    background-color: #ff8d1e;
}

ul.social-footer2 li a {
    display: block;
    height: 30px;
    width: 30px;
    text-align: center;
}

.btn {
    background-color: rgba(85, 85, 255, 0.932);
    color: #fff;
}

.btn:hover,
.btn:focus,
.btn.active {
    background: #4b92dc;
    color: #fff;
    -webkit-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    -moz-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    -ms-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    -o-box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
    -webkit-transition: all 250ms ease-in-out 0s;
    -moz-transition: all 250ms ease-in-out 0s;
    -ms-transition: all 250ms ease-in-out 0s;
    -o-transition: all 250ms ease-in-out 0s;
    transition: all 250ms ease-in-out 0s;

}
</style>
