<template>
  <div>
    <button 
      class="button is-danger"
      @click="VisibleModal"
    >
      編集
    </button>
    <div
      id="modal"
      class="modal"
      :class="modal_class"
    >
      <div
        class="modal-background"
        @click="VisibleModal"
      />
      <div
        class="modal-content"
        width="400px"
      >
        <div class="box">
          <div class="tabs is-centered">
            <ul>
              <li>
                <a>EDIT</a>
              </li>
            </ul>
          </div>
          <div class="list">
            <div class="field">
              <label class="label">タイトル</label>
              <div class="control">
                <input 
                  id="title"
                  v-model="editlist.title"
                  class="input"
                  type="text" 
                  placeholder="30字以内"
                >
              </div>
            </div>
            <div>
              <label class="label">登録している再生リスト（変更はできません）</label>
              <div v-if="editlist.playlistid">
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
            <div class="field">
              <label class="label">おすすめポイント</label>
              <div class="control">
                <textarea 
                  id="recommend"
                  v-model="editlist.recommend"
                  class="textarea" 
                  placeholder="300字以内" 
                  rows="5"
                />
              </div>
            </div>
            <div class="field is-grouped">
              <div class="control">
                <button
                  class="button is-danger"
                  @click="handleupdatelist"
                >
                  編集
                </button>
              </div>
              <div class="control">
                <button 
                  class="button is-light"
                  @click="VisibleModal"
                >
                  キャンセル
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
      <button
        class="modal-close is-large"
        @click="VisibleModal"
      />
    </div>
  </div>
</template>
<script>
import { mapGetters } from "vuex"
export default {
  name: "ListEdit",
  computed: {
    ...mapGetters("lists", ["list"]),
    editlist:{
      get(){
        return {
          id: this.list.id,
          title: this.list.title,
          playlistid: this.list.playlistid,
          recommend: this.list.recommend,
        }
      },
    }
  },
  data() {
    return {
      modal_class: "",
    }
  },
  methods: {
    handleupdatelist() {
      this.$emit('updatelist',this.editlist)
    },
    VisibleModal(){
      if (this.modal_class == "is-active"){
        this.modal_class = ""
      }else{
        this.modal_class = "is-active"
      }
    },
  },
}

</script>
<style scoped>
</style>
