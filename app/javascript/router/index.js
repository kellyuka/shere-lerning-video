import { createWebHistory, createRouter } from "vue-router";
import RegisterIndex from '../pages/register/index.vue'

const routes = [
  {
    path: '/register',
    component: RegisterIndex,
    name: "RegisterIndex"
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});
export default router
