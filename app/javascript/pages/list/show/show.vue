<template>
  <div class="section tile is-ancestor">
    <div class="tile is-vertical is-9 box">
      <div class="tile is-parent">
        <div class="tile is-child is-10">
          <p class="title">
            {{ list.title }}
          </p>
        </div>
        <div 
          v-if="isAuthUserList"
          class="tile is-child has-text-right"
        >
          <!-- 編集 -->
          <ion-icon 
            name="create-outline"
            class="edit-icon"
            @click="VisibleModal"
          />
          <!-- 削除-->
          <ion-icon
            name="trash-outline"
            class="edit-icon"
            @click="deletelist"
          />
        </div>
        <div
          id="modal"
          class="modal"
          :class="modal_class"
        >
          <Edit
            :list="list"
            @updatelist="updatelist"
            @VisibleModal="VisibleModal"
          />
        </div>
      </div>
      <div class="tile is-parent">
        <div class="tile is-child">
          <div class="tags">
            <ion-icon
              name="pricetag-outline"
              class="pr-2"
            />
            <span 
              v-for="tag in list.tags"
              :key="tag.id"
              class="tag is-light is-danger"
            >
              {{ tag.name }}
            </span>
          </div>
          <p class="subtitle">
            {{ list.recommend }}
          </p>
        </div>
      </div>
      <div class="tile">
        <div class="tile is-parent is-vertical is-3">
          <article class="tile is-child">
            <div class="has-text-centered">
              <img
                v-if="list.user.avatar_url"
                :src="list.user.avatar_url"
                alt="プロフィール画像"
                width="96"
              >
              <img
                v-else
                src="../../../../assets/images/noimage.png"
                alt="プロフィール画像"
                width="96"
              >
              <p class="subtitle">
                @{{ list.user.name }}
              </p>
            </div>
            <p class="subtitle">
              {{ list.user.profile }}
            </p>
          </article>
        </div>
        <div class="tile is-parent">
          <article class="tile is-child">
            <div class="content columns is-multiline">
              <div 
                v-for="video in list.videos"
                :key="video.id"
                class="column is-12"
              >
                <lite-youtube   
                  :videoid="video.videoid"
                  params="rel=0"
                />
              </div>
            </div>
          </article>
        </div>
      </div>
    </div>
    <div class="tile is-parent is-3">
      <article class="tile is-child">
        <div class="tabs is-centered">
          <ul>
            <li class="is-active">
              <a>COMMENT</a>
            </li>
          </ul>
        </div>
        <div class="content">
          <Comment
            :listid="list.id"
            :comments="comments"
          />
        </div>
      </article>
    </div>
  </div>
</template>
<script>
import Edit from '../conponents/edit.vue'
import Comment from './comment.vue'
import { mapGetters, mapActions } from "vuex"
export default {
  name: "ListShow",
  components: {
    Edit,
    Comment,
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
    ...mapGetters("youtube", ["videos"]),
    isAuthUserList() {
      if (this.authUser) {
        return this.authUser.id === this.list.user_id
      }
    },
  },
  methods: {
    ...mapActions("lists", [
    "showList",
    "updateList",
    "deleteList",
    ]),
    ...mapActions("comments", [
      "fetchComments",
    ]),
    ...mapActions("youtube", [
      "searchVideos",
    ]),
    async updatelist(list) {
      try {
        await 
        this.searchVideos(list.playlistid)
        for (var i in this.videos) {
          var video = this.videos[i].snippet.resourceId.videoId
          list.videos.push(video);
        }
        this.updateList(list)
        this.$router.push({ name: 'ListIndex' })
        this.$notify({
          title: "編集しました",
          text:"引き続き勉強を頑張りましょう!"
        });
      }
      catch (error) {
        this.$notify({
          type: "warn",
          title: "編集に失敗しました",
        });
      }
    },
    async deletelist() {
      try {
        await 
          this.deleteList(this.list)
          this.$router.push({ name: 'ListIndex' })
          this.$notify({
            title: "削除しました",
          });
      }
      catch (error) { 
        this.$notify({
          title: "削除に失敗しました",
        });
        console.log(error);
      }
    },
    VisibleModal(){
      if (this.modal_class == "is-active"){
        this.modal_class = ""
      }else{
        this.modal_class = "is-active"
      }
    }
  },
  created() {
    this.showList(this.id);
    this.fetchComments(this.id);
  }
}
</script>

<style scoped>
.edit-icon {
  font-size: 36px;
  color: red;
}
</style>
