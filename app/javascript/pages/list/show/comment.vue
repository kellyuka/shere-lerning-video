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
          <!-- 編集 -->
          <ion-icon 
            name="create-outline"
            class="edit-icon"
            @click="VisibleComment(comment)"
          />
          <!-- 削除-->
          <ion-icon
            name="trash-outline"
            class="edit-icon"
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
          @VisibleComment="VisibleComment"
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
                @click="create_comment"
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
import CommentEdit from './conponents/comment_edit.vue'

export default {
  name: "Comment",
  components: {
    Field,
    CommentEdit,
  },
  props: { 
    listid: {
      type: Number,
      required: true
    },
    comments: {
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
      list_id: '',
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
  },
  methods: {
    ...mapActions("comments", [
      "createComment","updateComment","deleteComment", 
    ]),
    isAuthUserComment(comment) {
        if (this.authUser) {
          return this.authUser.id === comment.user_id
        }
      },
    VisibleComment(comment){
      if (this.visiblecomment == false) {
        this.editcomment = comment
        this.visiblecomment = true
      } else {
        this.visiblecomment = false
      }
    },
    async create_comment() {
      try { 
        this.createcomment.list_id = this.listid 
        await this.createComment(this.createcomment);
        this.createcomment = {} 
      }
      catch (error) { console.log(error);}
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
.edit-icon {
  font-size: 24px;
  color: red;
}
</style>
