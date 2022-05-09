import axios from '../../plugins/axios'

const state = {
  favorites: [],
}

const getters =  {
  favorites: state => state.favorites,
}

const mutations = {
  setFavorites: (state, favorites) => { state.favorites = favorites},
  addFavorite: (state, favorite) => { state.favorites.push(favorite)},
  deleteFavorite: (state, deleteFavorite) => {
    state.favorites = state.favorites.filter(favorite => {
      return favorite.id != deleteFavorite.id
    })
  }
}
const actions = {
  fetchmyFavorites({ commit }) {
    axios.get('favorites')
      .then(res => { commit('setFavorites', res.data) })
      .catch(err => console.log(err.response));
  },
  createFavorite({ commit }, list) {
    return axios.post('lists/' + list.id + '/favorites', list)
    .then(res => { commit('addFavorite', res.data) })
    .catch(err => console.log(err.response));
  },
  
  deleteFavorite({ commit }, list) {
    return axios.delete('favorites/'+list.id)
    .then(res => { commit('deleteFavorite', res.data) })
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
