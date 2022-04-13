import { createWebHistory, createRouter } from "vue-router";
import LoginIndex from '../pages/login/index.vue'
import RegisterIndex from '../pages/register/index.vue'
import TopIndex from '../pages/top/index.vue'

const routes = [
  {
    path: '/',
    component: TopIndex,
    name: "TopIndex"
  },
  {
    path: '/register',
    component: RegisterIndex,
    name: "RegisterIndex"
  },
  {
    path: '/login',
    component: LoginIndex,
    name: "LoginIndex"
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});
export default router
