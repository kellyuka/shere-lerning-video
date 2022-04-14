<template>
  <div class="container is-max-desktop">
    <div class="level">
      <div class="level-left">
        <div class="level-item">
          <h2 class="subtitle">
            再生リスト
          </h2>
          <button @click="searchplayLists">
            検索
          </button>
        </div>
      </div>
    </div>
    <div v-show="results">
      <div class="columns is-multiline">
        <div
          v-for="(list) in results"
          :key="list.id"
          class="column is-3"
        >
          <article>
            <img
              width="320"
              height="180"
              :src="list.snippet.thumbnails.medium.url"
            >
            <h2 class="subtitle">
              {{ list.snippet.title }}
            </h2>
          </article>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: "SearchList",
  props: {
    authuser: {
      type: Object,
      required: true,
      channelid: {
        type: String,
        required: true
      },
    },
  },
  data: function() {
    return {
      results: null,
      params: {
        part: "snippet",
        type: "video",
        maxResults: "10",
        channelId: this.authuser.channelid,
        key: "AIzaSyDtPV43IJnQeVA64qCb8hJ7MIRr7k2DgrE"
      }
    };
  },
  methods: {
    searchplayLists: function() {
      var self = this;
      axios
        .get("https://www.googleapis.com/youtube/v3/playlists", {
          params: this.params
        })
        .then(function(res) {
          self.results = res.data.items;
        })
        .catch(function(err) {
          alert("検索に失敗しました。")
        })
    }
  }
};
</script>
<style scoped>
</style>
