<template>
  <div class="box content">
    <article 
      v-for="list in lists" 
      :key="list.id"
      class="media" 
    >
      <div class="media-left">
        <img
          v-if="list.user.avatar_url"
          :src="list.user.avatar_url"
          alt="プロフィール画像"
          class="image is-64x64"
        >
        <img
          v-else
          src="../../../../assets/images/noimage.png"
          alt="プロフィール画像"
          class="image is-64x64"
        >
      </div>
      <div class="media-content">
        <div class="content">
          @{{ list.user.name }}
          <router-link
            :to="'/lists/'+list.id"
          >
            <h3>{{ list.title }} </h3>
          </router-link>
          <p>{{ list.recommend }}</p>
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
          <div class="columns is-multiline">
            <div 
              v-for="video in list.videos"
              :key="video.id"
              class="column is-4"
            >
              <lite-youtube   
                :videoid="video.videoid"
                params="rel=0"
              />
            </div>
          </div>
        </div>
      </div>
      <div class="media-right">
        <span class="icon-text">
          <span class="icon">
            <ion-icon
              name="chatbox-ellipses-outline"
              size="large"
            />
          </span>
          {{ list.comments.length }}
          <template v-if="authUser">
            <template v-if="isAuthUserfavorite(list)">
              <span class="icon">
                <ion-icon
                  name="heart"
                  size="large"
                  class="favorited"
                  @click="unfavorite(list)"
                />
              </span>
            </template>
            <template v-else>
              <span class="icon">
                <ion-icon
                  name="heart-outline"
                  size="large"
                  @click="favorite(list)"
                />
              </span>
            </template>
          </template>
        </span>
      </div>
    </article>
  </div>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
export default {
  name: "ListItem",
  props: { 
    lists: {
      type: Object,
      required: true,
      tags: {
        type: Object,
        required: true
      },
      videos: {
        type: Object,
        required: true
      },
      user: {
        type: Object,
        required: true,
          name: {
            type: String,
            required: true,
          }
      },
    },
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("favorites", ["favorites"]),

  },
  created () {
    if(this.authUser){
      this.fetchmyFavorites();
    }
  },
  methods: {
    ...mapActions("favorites", ["fetchmyFavorites", "createFavorite", "deleteFavorite"]),
    favorite(list){
      this.createFavorite(list)
      this.$notify({
          title: "お気に入りに追加しました",
        });
    },
    unfavorite(list){
      this.deleteFavorite(list)
      this.$notify({
          title: "お気に入りから削除しました"
        });
    },
    isAuthUserfavorite(list) {
      return this.favorites.some(v => v.id === list.id)
    } 
  },
}
</script>
