<template>
<div class="section">
  <div class="tile is-ancestor box">
    <div class="tile is-vertical is-9">
      <div class="tile is-parent m-4">
        <article class="tile is-child">
          <p class="title">{{ list.title }}</p>
          <p class="subtitle">{{ list.recommend }}</p>
        </article>
      </div>
      <div class="tile">
        <div class="tile is-parent is-vertical is-2">
        <img src="/assets/canvas.jpg">
        <p class="subtitle has-text-centered">{{ list.user_id }}</p>
        </div>
        <div class="tile is-parent">
          <article class="tile is-child columns is-multiline">
            <lite-youtube  v-for="video in list.videos" 
              :key="video.id"
              :videoid="video.videoid"
              params="rel=0"
              class="column is-4"
            >
            </lite-youtube>
          </article>
        </div>
      </div>
    </div>
    <div class="tile is-parent">
      <article class="tile is-child notification is-danger">
        <div class="content">
          <p class="title">コメント</p>
          <p class="subtitle">みんなでコメントしよう！</p>
          <div class="content">
            Content
          </div>
        </div>
      </article>
    </div>
  </div>
</div>
</template>
<script>
import { mapGetters } from "vuex"
export default {
  name: "ListShow",
  props: { 
    id: {
      type: Number,
      required: true
    },
  },
  computed: {
    ...mapGetters("lists", ["list"]),
  },
}
</script>
