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
      <div v-if="isAuthUserComment(comment)">
        <div class="media-right">
          <ion-icon 
            name="create-outline"
            @click="visibleComment(comment)"
          />
          <ion-icon
            name="trash-outline"
            @click="delete_comment(comment)"
          />
        </div>
      </div>
    </article>
    <transition name="fade">
      <div
        v-show="visiblecomment"
        class="modal is-active"
      >
        <CommentEdit
          :comment="editcomment"
          @update_comment="update_comment"
          @visibleComment="visibleComment"
        />
      </div>
    </transition>
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
            <Field
              v-slot="{ field }"
              v-model="createcomment.body"
              name="createcomment"
            >
              <textarea
                id="createcomment"
                name="createcomment"
                v-bind="field"
                class="textarea"
                placeholder="みんなでコメントしよう"
              />
            </Field>
            <p class="help is-danger">
              {{ errors.createcomment }}
            </p>
          </div>
          <div class="field">
            <p class="control">
              <button
                class="button is-danger"
                :disabled="!meta.valid"
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
import { mapGetters, mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string } from 'yup';
import CommentEdit from '../../comment/edit.vue'

export default {
  name: "Comment",
  components: {
    Field,
    CommentEdit,
  },
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
    visiblecomment: false,
    }
  },
  setup() {
    const createcomment = {
      body: '',
    }
    const editcomment = ""
    const schema = object({
      createcomment: 
        string()
        .required('必須の項目です。')
    })
    const { errors, meta } = useForm({
      validationSchema: schema,
    })
    return {
      createcomment,
      editcomment,
      errors,
      meta,
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("comments", ["comments"]),
  },
  methods: {
    ...mapActions("comments", [
      "updateComment","deleteComment",
    ]),
    isAuthUserComment(comment) {
      if (this.authUser) {
        return this.authUser.id === comment.user_id
      }
    },
    handle_create_comment() {
      this.$emit('create-comment',this.createcomment)
      this.createcomment = {} 
    },
    visibleComment(comment){
      if (this.visiblecomment == false) {
        this.editcomment = comment
        this.visiblecomment = true
      } else {
        this.visiblecomment = false
      }
    },
    async update_comment(comment) {
      try {
        await
        this.updateComment(comment)
        this.visiblecomment = false
        this.$notify({
          title: "編集しました",
        });
      } catch (error) {
          this.$notify({
            type: "warn",
            title: "編集に失敗しました",
          });
        }
    },
     async delete_comment(comment) {
      try {
        await
        console.log("ugo") 
        this.deleteComment(comment)
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
  },
}
</script>

<style scoped>
ion-icon {
  font-size: 24px;
  color: red;
}
</style>
