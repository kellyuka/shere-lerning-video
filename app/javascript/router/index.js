import { createWebHistory, createRouter } from "vue-router";
import LoginIndex from '../pages/login/index.vue'
import RegisterIndex from '../pages/register/index.vue'
import AboutIndex from '../pages/top/about.vue'
import ListNew from '../pages/list/new.vue'
import ListShow from '../pages/list/show/show.vue'
import ListIndex from '../pages/list/index.vue'
import ProfileIndex from "../pages/profile/index";
import store from '../store'

const routes = [
  {
    path: '/',
    component: AboutIndex,
    name: "AboutIndex"
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
    path: '/lists/:list_id(\\d+)',
    component: ListShow,
    name: "ListShow",
    props: route => ({ id: Number(route.params.list_id) }) 
  },
  {
    path: '/lists',
    component: ListIndex,
    name: "ListIndex"
  },
  {
    path: "/profile",
    component: ProfileIndex,
    name: "ProfileIndex",
    meta: { requiredAuth: true },
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
