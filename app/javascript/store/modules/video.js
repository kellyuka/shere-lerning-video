import axios from 'axios';

const actions = {
  searchVideos({ commit },list) {
    return axios.get('https://www.googleapis.com/youtube/v3/playlistItems', {
      params: {
        part: 'snippet',
        playlistId: list.playlistid,
        key: process.env.VUE_APP_API_KEY,
      }
    });
  }
}

export default {
  namespaced: true,
  actions
}
