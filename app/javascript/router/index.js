import { createWebHistory, createRouter } from "vue-router";
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
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});
export default router
