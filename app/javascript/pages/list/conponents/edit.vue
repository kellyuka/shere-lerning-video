<template>
  <div>
    <div
      class="modal-background"
      @click="VisibleModal"
    />
    <div
      class="modal-content"
      width="400px"
    >
      <div class="box">
        <div class="tabs is-centered">
          <ul>
            <li class="is-active">
              <a>LIST EDIT</a>
            </li>
          </ul>
        </div>
        <div class="list">
          <div class="field">
            <label class="label">タイトル</label>
            <div class="control">
              <Field
                v-slot="{ field }"
                v-model="editlist.title"
                name="title"
              >
                <input
                  id="title"
                  name="title"
                  v-bind="field"
                  class="input"
                  type="text"
                  placeholder="100字以内で入力してください"
                >
              </Field>
            </div>
            <p class="help is-danger">
              {{ errors.title }}
            </p>
          </div>
          <div>
            <label class="label">登録している再生リスト（変更できません）</label>
            <div v-if="editlist.playlistid">
              <iframe
                width="560"
                height="315"
                :src="'https://www.youtube.com/embed/videoseries?controls=0&amp;list='+ list.playlistid"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
              />
            </div>
          </div>
          <div class="field">
            <label class="label">おすすめポイント</label>
            <div class="control">
              <Field
                v-slot="{ field }"
                v-model="editlist.recommend"
                name="recommend"
              >
                <textarea
                  id="recommend"
                  name="recommend"
                  v-bind="field"
                  class="textarea"
                  placeholder="1000字以内で入力してください"
                  rows="5"
                />
              </Field>
            </div>
            <p class="help is-danger">
              {{ errors.recommend }}
            </p>
          </div>
          <div class="field">
            <label class="label">タグ</label>
            <div class="control">
              <v-select 
                v-model="list.tags"
                label="name"
                :options="tags"
                multiple
                taggable
              />
            </div>
          </div>
          <div class="field is-grouped">
            <div class="control">
              <button
                class="button is-danger"
                :disabled="!meta.valid"
                @click="handleupdatelist"
              >
                編集
              </button>
            </div>
            <div class="control">
              <button
                class="button is-light"
                @click="VisibleModal"
              >
                キャンセル
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
    <button
      class="modal-close is-large"
      @click="VisibleModal"
    />
  </div>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string } from 'yup';

export default {
  name: "ListEdit",
  components: {
    Field,
  },
  props: { 
    list: {
      type: Object,
      required: true
    },
  },
  setup() {
    const schema = object({
      title: 
        string()
        .required('必須の項目です')
        .max(100,("${max}文字以内で入力してください")),
      recommend: 
        string()
        .required('必須の項目です')
        .max(1000,("${min}文字以内で入力してください")),
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
    ...mapGetters("tags", ["tags"]),
    editlist:{
      get(){
        return {
          id: this.list.id,
          title: this.list.title,
          playlistid: this.list.playlistid,
          videos: [],
          recommend: this.list.recommend,
          list_tags: this.list.tags.map((t) => {return t.name}),
        }
      },
    }
  },
  methods: {
    ...mapActions("tags", [
      "fetchTags",
    ]),
    handleupdatelist() {
      this.$emit('updatelist',this.editlist)
    },
    VisibleModal(){
      this.$emit('VisibleModal')
    },
  },
  created () {
    this.fetchTags();
  },
}
</script>
<style scoped>
</style>
