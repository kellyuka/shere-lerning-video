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
  updateComment: (state, updateComment) => {
    const index = state.comments.findIndex(comment => {
      return comment.id === updateComment.id 
    })
    state.comments.splice(index, 1, updateComment);
  },
  deleteComment: (state, deleteComment) => { 
    state.comments = state.comments.filter(comment => {
      return comment.id != deleteComment.id
    })
  }
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
  updateComment({ commit },comment) {
    axios.patch('comments/'+ comment.id, comment)
      .then(res => { commit('updateComment', res.data) })
      .catch(err => console.log(err.response));
  },
  deleteComment({ commit }, comment) {
    return axios.delete('comments/'+ comment.id)
      .then(res => { commit('deleteComment', res.data) })
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
