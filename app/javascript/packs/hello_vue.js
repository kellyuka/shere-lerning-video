import { createApp } from "vue";
import App from "../app.vue";
import router from '../router'
import axios from '../plugins/axios'

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(App);
    app.use(router).mount("#app")
    //app.config.globalProperties.$axios = axios
});

