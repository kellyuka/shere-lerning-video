import { createApp } from "vue";
import App from "../app.vue";
import router from '../router'
import store from '../store'
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(App);
    app.component('v-select', vSelect)
    app.use(router).use(store).mount("#app")
    //app.config.globalProperties.$axios = axios
});

