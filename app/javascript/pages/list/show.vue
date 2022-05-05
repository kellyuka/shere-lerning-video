<template>
  <div class="section"> 
    <div class="tile is-vertical box">
      <div class="tile is-parent">
        <article class="tile is-child">
          <p class="title">
            {{ list.title }}
          </p>
          <p class="subtitle">
            {{ list.recommend }}
          </p>
        </article>
        <div 
          v-if="isAuthUserList"
          class="tile is-child has-text-right"
        >
          <button 
            class="button is-danger m-2"
            @click="VisibleModal"
          >
            編集
          </button>
          <button 
            class="button is-danger m-2"
            @click="deletelist"
          >
            削除
          </button>
        </div>
        <div
          id="modal"
          class="modal"
          :class="modal_class"
        >
          <Edit
            @updatelist="updatelist"
            @VisibleModal="VisibleModal"
          />
        </div>
      </div>
      <div class="tile is-ancestor">
        <div class="tile is-vertical is-9">
          <div class="tile is-parent">
            <div class="tile is-child is-2">
              <img src="/assets/canvas.jpg">
              <p class="subtitle has-text-centered">
                {{ list.user_id }}
              </p>
            </div>
            <div class="tile is-child">
              <article class="tile is-child columns is-multiline">
                <div 
                  v-for="video in list.videos"
                  :key="video.id"
                  class="column is-6"
                >
                  <lite-youtube   
                    :videoid="video.videoid"
                    params="rel=0"
                  />
                </div>
              </article>
            </div>
          </div>
        </div>
        <Comment
          :comments="comments"
          :auth-user="authUser"
          @create-comment="create_comment"
        />
      </div>
    </div>
  </div>
</template>
<script>
import Comment from './conponents/comment.vue'
import Edit from './conponents/edit.vue'
import { mapGetters, mapActions } from "vuex"
export default {
  name: "ListShow",
  components: {
    Comment,
    Edit,
  },
  props: { 
    id: {
      type: Number,
      required: true
    },
  },
  data() {
    return {
      modal_class: "",
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("lists", ["list"]),
    ...mapGetters("comments", ["comments"]),
    isAuthUserList() {
      if (this.authUser) {
        return this.authUser.id === this.list.user_id
      }
    }  
  },
  methods: {
    ...mapActions("lists", [
    "showList",
    "updateList",
    "deleteList",
    ]),
    ...mapActions("comments", [
      "createComment",
      "fetchComments",
    ]),
    async create_comment(comment) {
      comment.list_id = this.list.id 
      try {
        await this.createComment(comment);
      }
      catch (error) { console.log(error);}
    },
    async updatelist(list) {
      try {
        await 
          this.updateList(list)
          this.$router.push({ name: 'ListIndex' })
      }
      catch (error) { alert("登録失敗"),console.log(error); }
    },
    async deletelist() {
      try {
        await 
          this.deleteList(this.list)
          this.$router.push({ name: 'ListIndex' })
      }
      catch (error) { alert("登録失敗"),console.log(error); }
    },
    VisibleModal(){
      if (this.modal_class == "is-active"){
        this.modal_class = ""
      }else{
        this.modal_class = "is-active"
      }
    }
  },
  created () {
    this.showList(this.id);
    this.fetchComments(this.id);
  }
}
</script>
