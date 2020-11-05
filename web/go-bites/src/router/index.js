import { createWebHistory, createRouter} from "vue-router";
import Restaurant from "../views/Restaurant.vue";
import Login from "../views/Login.vue";

const routes = [
    {
        path: "/login",
        name: "Login",
        component: Login,
    },
    {
        path: "/restaurant",
        name: "Restaurant",
        component: Restaurant,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router;