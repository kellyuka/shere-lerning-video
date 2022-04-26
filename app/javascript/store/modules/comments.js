import axios from '../../plugins/axios'

const state = {
  comments: [],
}

const getters =  {
  comments: state => state.comments,
}

const mutations = {
  setComments: (state, comments) => { state.comments = comments},
  addComment: (state, comment) => { state.comments.push(comment)},

}
const actions = {
  fetchComments({ commit },id) {
    axios.get('comments/'+ id)  
    .then(res => { commit('setComments', res.data) })
    .catch(err => console.log(err.response));
  },
  createComment({ commit }, comment) {
    axios.post('comments', comment)
      .then(res => { commit('addComment', res.data) })
      .catch(err => console.log(err.response));
  },
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
