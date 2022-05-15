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
  addList: (state, list) => { state.lists.unshift(list)},
  updateList: (state, updateList) => {
    const index = state.lists.findIndex(list => {
      return list.id === updateList.id 
    })
    state.lists.splice(index, 1, updateList);
  },
  deleteList: (state, deleteList) => { 
    state.lists = state.lists.filter(list => {
      return list.id != deleteList.id
    })
  }
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
    .then(res => { commit('addList', res.data) })
    .catch(err => console.log(err.response));
  },
  updateList({ commit },list) {
    return axios.patch('lists/'+list.id, list)
      .then(res => { commit('updateList', res.data) })
      .catch(err => console.log(err.response));
  },
  deleteList({ commit }, list) {
    return axios.delete('lists/'+list.id)
      .then(res => { commit('deleteList', res.data) })
      .catch(err => console.log(err.response));
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
