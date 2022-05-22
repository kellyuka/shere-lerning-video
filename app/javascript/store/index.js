import { createStore } from 'vuex'
import users from './modules/users'
import lists from './modules/lists'
import youtube from './modules/youtube'
import comments from './modules/comments'
import tags from './modules/tags'
import favorites from './modules/favorites'
import passwordresets from './modules/passwordresets'

export default createStore({
  modules: {
    users,
    lists,
    youtube,
    comments,
    tags,
    favorites,
    passwordresets,
  }
})
