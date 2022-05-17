<template>
  <div class="field">
    <label class="label">
      *再生リスト
      <span
        class="icon-text"
        @click="VisiblePlaylistmodal"
      >
        <span class="icon">
          <ion-icon 
            name="help-circle" 
            size="large"
          />
        </span>
      </span>
    </label>
    <template v-if="channelid">
      <div class="control pb-2">
        <button 
          class="button is-small is-danger is-outlined is-rounded"
          @click="searchLists"
        >
          <span>Youtubeから取得</span>
          <span class="icon">
            <ion-icon 
              name="arrow-down-circle-outline"
              size="large"
            />
          </span>
        </button>
      </div>
    </template>
    <template v-else>
      <p class="help is-danger">
        チャンネルIDを
        <router-link
          :to="{ name: 'ProfileIndex' }"
          class="link"
        >
          プロフィール
        </router-link>
        から登録してください     
      </p>
    </template>
    <div v-if="results">
      <div v-if="!results.length">
        <p class="help is-danger">
          再生リストがありません。Youtubeで再生リストを作成してください
        </p>
      </div>
      <div v-else>
        <div class="columns is-multiline">
          <div
            v-for="(list) in results"
            :key="list.id"
            class="column is-2"
            @click="select(list.id)"
          >
            <img :src="list.snippet.thumbnails.medium.url">
            <h2 class="is-size-6">
              {{ list.snippet.title }}
            </h2>
          </div>
        </div>
      </div>
    </div>
    <div class="column is-2">
      <img src="https://i.ytimg.com/vi/9xxXKkwpRg4/mqdefault.jpg"><h2 class="is-size-6">
        jwt
      </h2>
    </div>
  </div>
  <transition name="fade">
    <PlaylistModal
      v-if="playlistmodal"
      @Visiblemodal="VisiblePlaylistmodal"
    />
  </transition>
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
      this.searchplayLists(this.channelid)
      .then(res => { this.results = res.data.items },this.$emit('Searched'))
      .catch(err => {
        this.$notify({
          type: "warn",
          title: "再生リストの取得に失敗しました",
          text: "チャンネルIDをご確認ください",
        });
      })
    },
    select(id) {
      this.$emit('select',id)
    },
    Searched() {
      this.$emit('Searched')
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
