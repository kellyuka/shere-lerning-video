import { createStore } from 'vuex'
import users from './modules/users'
import lists from './modules/lists'
import videos from './modules/video'

export default createStore({
  modules: {
    users,
    lists,
    videos,
  }
})
