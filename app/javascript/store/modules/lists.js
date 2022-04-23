import axios from '../../plugins/axios'

const state = {
  lists: []
}

const getters =  {
  lists: state => state.lists,
}

const mutations = {
  setLists: (state, lists) => { state.lists = lists},
}
const actions = {
  fetchLists({ commit }) {
    axios.get('lists')
      .then(res => { commit('setLists', res.data) })
      .catch(err => console.log(err.response));
  },
  createList({ commit }, list) {
    return axios.post('lists', list)
  },
  createVideo({ commit },[list,videos]) {
    return axios.post('videos', {video: videos, list: list})
  },
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
