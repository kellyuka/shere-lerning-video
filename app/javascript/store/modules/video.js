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
  searchVideos({ commit },playlistid) {
    return axios.get('https://www.googleapis.com/youtube/v3/playlistItems', {
      params: {
        part: 'snippet',
        playlistId: playlistid,
        key: process.env.YOUTUBE_API_KEY,
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
