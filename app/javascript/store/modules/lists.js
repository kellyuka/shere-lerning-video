import axios from '../../plugins/axios'

const state = {
  lists: [],
  list: [],
}

const getters =  {
  lists: state => state.lists,
  list: state => state.list,
}

const mutations = {
  setLists: (state, lists) => { state.lists = lists},
  setList: (state, list) => { state.list = list},
}
const actions = {
  fetchLists({ commit }) {
    axios.get('lists')  
    .then(res => { commit('setLists', res.data) })
    .catch(err => console.log(err.response));
  },
  showList({ commit }, id) {
    axios.get('lists/'+ id)
    .then(res => { commit('setList', res.data) })
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
