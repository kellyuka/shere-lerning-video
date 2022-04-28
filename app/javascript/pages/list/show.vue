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
        <Edit
          @updatelist="updatelist"
          @changelist="changelist"
          @VisibleModal="VisibleModal"
        />
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
          :list_id="list.id"
          :comments="comments"
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
  computed: {
    ...mapGetters("lists", ["list"]),
    ...mapGetters("comments", ["comments"]),
  },
  methods: {
    ...mapActions("lists", [
    "showList",
    "updateList",
    ]),
    ...mapActions("comments", [
      "createComment",
      "fetchComments",
    ]),
    async create_comment(comment) {
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
    }
  },
  created () {
    this.showList(this.id);
    this.fetchComments(this.id);
  }
}
</script>
