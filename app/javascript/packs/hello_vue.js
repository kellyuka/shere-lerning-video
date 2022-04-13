import { createApp } from "vue";
import App from "../app.vue";
import router from '../router'
import store from '../store'

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(App);
    app.use(router).use(store).mount("#app")
    //app.config.globalProperties.$axios = axios
});

