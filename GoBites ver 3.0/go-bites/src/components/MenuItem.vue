<template>
    <div id="menuItem">
        <div v-if="menuItems.length == 0">
            <h1>There is no menu available</h1>
        </div>
        
        <div class="row" v-if="menuItems.length != 0">
            <div class="col-md-3" v-for="(menuItem, id) in menuItems" :key="id">
                <div class="card custom-card">
                    <img :src="`${getItemPhoto(menuItem)}`" class="card-img-top" :alt="menuItem.itemPhoto">
                    <div class="card-body">
                        <h5 class="card-title">{{ menuItem.itemName }}</h5>
                        <p class="card-text">{{ menuItem.itemDesc }}</p>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">RM{{ menuItem.itemPrice }}</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import resourceURL from '../http/resource/http-resource.js';

export default {
    name: 'MenuItem',
    props: {
        menuItems: {
            type: Array,
        },
    },
    data() {
        return {
            resourcesURL: resourceURL + "/menu/items/",
        }
    },
    methods: {
        getItemPhoto(menuItem) {
            console.log(this.resourcesURL);
            if(menuItem.itemPhoto == undefined) {
                return this.resourcesURL + "default.png";
            }
            // // To check whether the image exist
            // fetch(this.resourcesURL + menuItem.itemPhoto, { 
            //         method: 'GET',
            //         mode: 'cors',
            //         cache: 'no-cache',
            //         credentials: 'omit',
            //         headers: {
            //             "Content-Type": "application/json"
            //         }
            //     })
            //     .then(res => {
            //         if (res.ok) {
            //             return this.resourcesURL + menuItem.itemPhoto;
            //         } else {
            //             return this.resourcesURL + "default.png";
            //         }
            //     })
            //     .catch(err => console.log('Error:', err));
            return this.resourcesURL + menuItem.itemPhoto;
        }
    },
}
</script>

<style lang="scss" scoped>
#menuItem {
    .custom-card {
        margin-top: 40px;
        margin-bottom: 40px;
        margin-left: 5%;
        margin-right: 5%;
        max-width: 100%;
        box-shadow:
            0 2.8px 2.2px rgba(0, 0, 0, 0.034),
            0 6.7px 5.3px rgba(0, 0, 0, 0.048),
            0 12.5px 10px rgba(0, 0, 0, 0.06),
            0 22.3px 17.9px rgba(0, 0, 0, 0.072),
            0 41.8px 33.4px rgba(0, 0, 0, 0.086),
            0 100px 80px rgba(0, 0, 0, 0.12);

        img {
            height: 280px;
            width: 100%;
        }
    }
}
</style>