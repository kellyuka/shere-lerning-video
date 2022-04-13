import { createStore } from 'vuex'
import users from './modules/users'

export default createStore({
  // state: Vuexで管理する状態を定義
  // [state]がコンポーネントにおける[data]に相当
  modules: {
    users
  }
})
