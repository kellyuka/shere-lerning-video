<template>
  <div class="tile is-parent box">
    <div class="tile is-child ">
      <p class="title ">
        コメント
      </p>
      <article 
        v-for="comment in comments" 
        :key="comment.id"
        class="media"
      >
        <figure class="media-left">
          <p class="image is-48x48">
            <img src="https://bulma.io/images/placeholders/128x128.png">
          </p>
        </figure>
        <div class="media-content">
          <div class="content">
            <strong>@{{ comment.user.name }}</strong>
            <p>{{ comment.body }}</p>
          </div>
        </div>
      </article>
      <article class="media">
        <figure class="media-left">
          <p class="image is-48x48">
            <img src="https://bulma.io/images/placeholders/128x128.png">
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
    </div>
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
