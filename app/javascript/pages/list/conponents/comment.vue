<template>
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
            :src="authUser.avatar_url"
          >
        </p>
      </figure>
      <div class="media-content">
        <div class="field">
          <textarea
            id="comment"
            v-model="comment.body"
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
      comment: {
        body: '',
      },
    }
  },
  methods: {
    handle_create_comment() {
      this.$emit('create-comment',this.comment)
      this.comment = {} 
    },
  },
}
</script>
