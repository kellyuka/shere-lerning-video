import { createStore } from 'vuex'
import users from './modules/users'
import lists from './modules/lists'

export default createStore({
  modules: {
    users,
    lists,
  }
})
