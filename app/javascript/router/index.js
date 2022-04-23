import { createWebHistory, createRouter } from "vue-router";
import LoginIndex from '../pages/login/index.vue'
import RegisterIndex from '../pages/register/index.vue'
import TopIndex from '../pages/top/index.vue'
import ListNew from '../pages/list/new.vue'
import ListIndex from '../pages/list/index.vue'
import store from '../store'

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
  {
    path: '/listnew',
    component: ListNew,
    name: "ListNew"
  },
  {
    path: '/lists',
    component: ListIndex,
    name: "ListIndex"
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser')
  .then((authUser) => {
    if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
      next({ name: 'LoginIndex' });
    } else {
      next();
    }
  })
});
export default router
