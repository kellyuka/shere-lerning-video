<template>
  <div class="box container">
    <div class="field">
      <label class="label">タイトル</label>
      <div class="control">
        <input 
          id="title"
          v-model="list.title"
          class="input"
          type="text" 
          placeholder="30字以内"
        >
      </div>
    </div>
    <div
      v-if="authUser.channelid"
      class="field"
    >
      <SearchList 
        :channelid="authUser.channelid"
        @select="select"
      />
      <div>
        <label class="label">選択中の再生リスト</label>
        <div v-if="list.playlistid">
          <iframe
            width="560"
            height="315"
            :src="'https://www.youtube.com/embed/videoseries?controls=0&amp;list='+ list.playlistid"
            title="YouTube video player"
            frameborder="0"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
          />
        </div>
      </div>
    </div>
    <div class="field">
      <label class="label">コメント</label>
      <div class="control">
        <textarea 
          id="recommend"
          v-model="list.recommend"
          class="textarea" 
          placeholder="300字以内" 
          rows="3"
        />
      </div>
    </div>
    <div class="field">
      <label class="label">タグ</label>
      <div class="control">
        <v-select 
          v-model="list.tag_names"
          label="name"
          :options="options"
          :reduce="options => options.name"
          :selectable="function(){ return list.tag_names.length < 5}"
          placeholder="5個まで選べます" 
          multiple
          taggable
        />
      </div>
    </div>
    <div class="field is-grouped">
      <div class="control">
        <button
          class="button is-danger"
          @click="createlist"
        >
          登録
        </button>
      </div>
      <div class="control">
        <button class="button is-light">
          キャンセル
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import SearchList from './conponents/youtube/SearchList.vue'

export default {
  name: "ListNew",
  components: {
    SearchList,
  },
  data() {
    return {
      newlist: [],
      list: {
        title: '',
        playlistid: '',
        recommend:'',
        tag_names: [],
        },
    }
  },
  computed: {
      ...mapGetters("users", ["authUser"]),
      ...mapGetters("tags", ["tags"]),
    options:{
      get(){ return this.tags }
    }
  },
  methods: {
    ...mapActions("lists", [
      "createList",
      "createVideo",
    ]),
    ...mapActions("videos", [
      "searchVideos",
    ]),
    ...mapActions("tags", [
      "fetchTags",
    ]),
    async createlist() {
      try {
        await 
          this.createList(this.list)
            .then(res => this.newlist = res.data)
            .catch(err => { alert("リスト登録失敗"), console.log(err) })
          this.searchVideos(this.newlist)
            .then(res => this.createVideo([ this.newlist, res.data.items ]))
            .catch(err => { alert("ビデオ登録失敗"), console.log(err) })
          this.$router.push({ name: 'ListIndex' })
      } catch (error) {
        alert("登録失敗")
        console.log(error);
      }
    },
    select(id) {
      this.list.playlistid = id
    },
  },
  created () {
    this.fetchTags();
  },
}
</script>
