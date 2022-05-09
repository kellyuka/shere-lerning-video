import axios from '../../plugins/axios'

const state = {
  tags: [],
  tag: [],
}

const getters =  {
  tags: state => state.tags,
  tag: state => state.tag,
}

const mutations = {
  setTags: (state, tags) => { state.tags = tags},
  setTag: (state, tag) => { state.tag = tag},
  updateTag: (state, updateTag) => {
    const index = state.tags.findIndex(tag => {
      return tag.id === updateTag.id 
    })
    state.tags.splice(index, 1, updateTag);
  },
  deleteTag: (state, deleteTag) => { 
    state.tags = state.tags.filter(tag => {
      return tag.id != deleteTag.id
    })
  }
}
const actions = {
  fetchTags({ commit }) {
    axios.get('tags')  
    .then(res => { commit('setTags', res.data) })
    .catch(err => console.log(err.response));
  },
  showTag({ commit }, id) {
    axios.get('tags/'+ id)
    .then(res => { commit('setTag', res.data) })
    .catch(err => console.log(err.response));
  },
  createTag({ commit }, tag) {
    return axios.post('tags', tag)
  },
  updateTag({ commit },tag) {
    return axios.patch('tags/'+tag.id, tag)
      .then(res => { commit('updateTag', res.data) })
      .catch(err => console.log(err.response));
  },
  deleteTag({ commit }, tag) {
    return axios.delete('tags/'+tag.id)
      .then(res => { commit('deleteTag', res.data) })
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
