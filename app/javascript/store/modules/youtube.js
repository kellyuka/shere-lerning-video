import axios from 'axios';

const state = {
  videos: [],
}
const getters =  {
  videos: state => state.videos,
}
const mutations = {
  setVideos: (state, videos) => { state.videos = videos},
}
const actions = {
  searchplayLists({ commit }, channelid){
    return axios.get("https://www.googleapis.com/youtube/v3/playlists", {
      params: {
        part: "snippet",
        type: "video",
        channelId: channelid,
        key: 'AIzaSyCQtHNjxHRZq_H5ledUA-XIQW2-k3lE5cY',
        maxResults: 50,
      }
    })
  },
  searchVideos({ commit },playlistid) {
    return axios.get('https://www.googleapis.com/youtube/v3/playlistItems', {
      params: {
        part: 'snippet',
        playlistId: playlistid,
        key: 'AIzaSyCQtHNjxHRZq_H5ledUA-XIQW2-k3lE5cY',
        maxResults: 50,
      }
    })
    .then(res => { commit('setVideos', res.data.items) })
  }
}

export default {
  namespaced: true,
  state,
  getters,
  mutations,
  actions
}
