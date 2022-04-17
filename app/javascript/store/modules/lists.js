import axios from '../../plugins/axios'

const actions = {
  createList({ commit }, list) {
    return axios.post('lists', list)
  },
}

export default {
  namespaced: true,
  actions
}
