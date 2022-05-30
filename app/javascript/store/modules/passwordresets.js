import axios from '../../plugins/axios'

const state = {
  editUser: null
}

const getters =  {
  editUser: state => state.editUser
}

const mutations = {
  setUser: (state, user) => {
    state.editUser = user
  }
}

const actions = {
  createPasswordReset({ commit }, user ) {
    return axios.post('/password_resets', user)
  },
  fetchEditUser({ commit }, id) {
    return axios.get(`/password_resets/${id}/edit`)
    .then(res => { commit('setUser', res.data) })
  },
  updatePasswordReset({ commit }, data) {
    return axios.patch(`/password_resets/${data.id}`, data.user)
  },
}
export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
