<template>
  <div>
    <label class="label">*再生リスト
      <span
        class="icon-text"
        @click="VisiblePlaylistmodal"
      >
        <span class="icon">
          <ion-icon 
            name="help-circle" 
          />
        </span>
      </span>
    </label>
    <button @click="searchLists">
      検索
    </button>
    <div v-show="results">
      <div class="columns is-multiline">
        <div
          v-for="(list) in results"
          :key="list.id"
          class="column is-2"
          @click="select(list.id)"
        >
          <img :src="list.snippet.thumbnails.medium.url">
          <h2 class="subtitle">
            {{ list.snippet.title }}
          </h2>
        </div>
      </div>
    </div>
    <transition name="fade">
      <PlaylistModal
        v-if="playlistmodal"
        @Visiblemodal="VisiblePlaylistmodal"
      />
    </transition>
  </div>
</template>

<script>
import { mapActions } from "vuex"
import PlaylistModal from './playlistmodal.vue'

export default {
  name: "SearchList",
  components: {
    PlaylistModal,
  },
  props: {
    channelid:{
      type: String,
      required: true
    }
  },
  data: function() {
    return {
      results: "",
      playlistmodal: false,
    };
  },
  methods: {
    ...mapActions("youtube", ["searchplayLists"]),
    searchLists() {
      if (this.channelid !== "") {
      this.searchplayLists(this.channelid)
        .then(res => { this.results = res.data.items })
        .catch(err => {
          this.$notify({
            type: "warn",
            title: "再生リストの取得に失敗しました",
            text: "チャンネルIDをご確認ください",
          });
        })
      } else { 
        this.$notify({
            type: "warn",
            title: "チャンネルIDを登録してください",
            text: "プロフィールから登録できます。",
          });
      }
    },
    select(id) {
      this.$emit('select',id)
    },
    VisiblePlaylistmodal(){
      if (this.playlistmodal == false) {
        this.playlistmodal = true
      } else {
        this.playlistmodal = false
      }
    },
  }
};
</script>
<style scoped>
</style>
