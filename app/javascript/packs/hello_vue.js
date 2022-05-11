import { createApp } from "vue";
import App from "../app.vue";
import router from '../router'
import store from '../store'
import vSelect from 'vue-select'
import 'vue-select/dist/vue-select.css';
import Notifications from '@kyvg/vue3-notification'

document.addEventListener("DOMContentLoaded", () => {
    const app = createApp(App);
    app.component('v-select', vSelect)
    app.use(router).use(store).use(Notifications).mount("#app")
});
