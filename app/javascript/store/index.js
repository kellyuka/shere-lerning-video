import { createStore } from 'vuex'
import users from './modules/users'
import lists from './modules/lists'
import videos from './modules/video'
import comments from './modules/comments'

export default createStore({
  modules: {
    users,
    lists,
    videos,
    comments,
  }
})
