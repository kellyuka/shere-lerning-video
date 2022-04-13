import axios from '../../plugins/axios'

const state = {
  authUser: null
}

const getters =  {
  authUser: state => state.authUser
}

const mutations = {
  setUser: (state, user) => {
    state.authUser = user
  }
}

const actions = {
  async loginUser({ commit }, user) {
    const sessionsResponse = await axios.post('sessions', user)
    localStorage.auth_token = sessionsResponse.data.token
    axios.defaults.headers.common['Authorization'] = `Bearer ${localStorage.auth_token}`
    const userResponse = await axios.get('users/me')
    commit('setUser', userResponse.data)
  },
}


export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
