<template>
  <div>
    <div
      class="modal-background"
      @click="handleVisibleModal"
    />
    <div
      class="modal-content"
    >
      <div class="box">
        <div class="tabs is-centered">
          <ul>
            <li class="is-active">
              <a>COMMENT EDIT</a>
            </li>
          </ul>
        </div>
        <div class="field">
          <label class="label">コメント</label>
          <div class="control">
            <Field
              v-slot="{ field }"
              v-model="editcomment.body"
              name="editcomment"
            >
              <textarea
                id="editcomment"
                name="editcomment"
                v-bind="field"
                class="textarea"
              />
            </Field>
          </div>
          <p class="help is-danger">
            {{ errors.editcomment }}
          </p>
        </div>
        <div class="field is-grouped">
          <div class="control">
            <button
              class="button is-danger"
              :disabled="!meta.valid"
              @click="handleUpdateComment"
            >
              編集
            </button>
          </div>
          <div class="control">
            <button
              class="button is-light"
              @click="handleVisibleModal"
            >
              キャンセル
            </button>
          </div>
        </div>
      </div>
    </div>
    <button
      class="modal-close is-large"
      @click="handleVisibleModal"
    />
  </div>
</template>
<script>
import { useForm, Field } from 'vee-validate';
import { object, string } from 'yup';

export default {
  name: "CommentEdit",
  components: {
    Field,
  },
  props: { 
    comment: {
      type: Object,
      required: true
    },
  },
  setup() {
    const schema = object({
      editcomment: 
        string()
        .required('必須の項目です'),
    })
    const { errors, meta } = useForm({
      validationSchema: schema,
    });
    return {
      errors,
      meta,
    };
  },
  computed: {
    editcomment:{
      get(){
        return {
          id : this.comment.id,
          body :  this.comment.body,
        }
      },
    }
  },
  methods: {
    handleUpdateComment() {
      this.$emit('update_comment',this.editcomment)
    },
    handleVisibleModal(){
      this.$emit('visibleComment')
    },
  },
}
</script>
