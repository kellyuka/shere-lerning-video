<template>
  <div>
    <article 
      v-for="comment in comments" 
      :key="comment.id"
      class="media"
    >
      <figure class="media-left">
        <img
          v-if="comment.user.avatar_url"
          :src="comment.user.avatar_url"
          alt="プロフィール画像"
          class="image is-64x64"
        >
        <img
          v-else
          src="../../../../assets/images/noimage.png"
          alt="プロフィール画像"
          class="image is-64x64"
        >
      </figure>
      <div class="media-content">
        <div class="content">
          <strong>@{{ comment.user.name }}</strong>
          <p>{{ comment.body }}</p>
        </div>
      </div>
    </article>
    <template v-if="authUser">
      <article class="media">
        <figure class="media-left">
          <p class="image is-64x64">
            <img
              v-if="authUser.avatar_url"
              :src="authUser.avatar_url"
              alt="プロフィール画像"
              class="image is-64x64"
            >
            <img
              v-else
              src="../../../../assets/images/noimage.png"
              alt="プロフィール画像"
              class="image is-64x64"
            >
          </p>
        </figure>
        <div class="media-content">
          <div class="field">
            <textarea
              id="createcomment"
              v-model="createcomment.body"
              class="textarea"
              placeholder="みんなでコメントしよう"
            />
          </div>
          <div class="field">
            <p class="control">
              <button
                class="button is-danger"
                @click.prevent="handle_create_comment"
              >
                投稿
              </button>
            </p>
          </div>
        </div>
      </article>
    </template>
  </div>
</template>
<script>
export default {
  name: "Comment",
  props: { 
    comments: {
      type: Object,
      required: true
    },
    authUser: {
      type: Object,
      required: true
    },
  },
  data() {
    return {
      createcomment: {
        body: '',
      },
    }
  },
  methods: {
    handle_create_comment() {
      this.$emit('create-comment',this.createcomment)
      this.createcomment = {} 
    },
  },
}
</script>
