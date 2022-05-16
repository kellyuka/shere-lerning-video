<template>
  <div class="section">
    <div class="box container">
      <div class="tabs is-centered">
        <ul>
          <li class="is-active">
            <a>NEW LIST</a>
          </li>
        </ul>
      </div>
      <div class="has-text-right">
        <span class="help">* 必須項目</span>
      </div>
      <div class="field">
        <label class="label">*タイトル</label>
        <div class="control">
          <Field
            v-slot="{ field }"
            v-model="list.title"
            name="title"
          >
            <input
              id="title"
              name="title"
              v-bind="field"
              class="input"
              type="text" 
              placeholder="100字以内"
            >
          </Field>
        </div>
        <p class="help is-danger">
          {{ errors.title }}
        </p>
      </div>
      <div
        class="field"
      >
        <SearchList 
          :channelid="authUser.channelid"
          @select="select"
        />
        <div>
          <p class="help is-danger">
            {{ errors.playlistid }}
          </p>
          <div v-if="list.playlistid">
            <label class="label">選択中の再生リスト</label>
            <Field
              v-slot="{ field }"
              v-model="list.playlistid"
              name="playlistid"
            >
              <iframe
                id="playlistid"
                name="playlistid"
                v-bind="field"
                width="560"
                height="315"
                :src="'https://www.youtube.com/embed/videoseries?controls=0&amp;list='+ list.playlistid"
                title="YouTube video player"
                frameborder="0"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen
              />
            </Field>
          </div>
        </div>
      </div>
      <div class="field">
        <label class="label">*おすすめポイント</label>
        <div class="control">
          <Field
            v-slot="{ field }"
            v-model="list.recommend"
            name="recommend"
          >
            <textarea
              id="recommend"
              name="recommend"
              v-bind="field"
              class="textarea" 
              placeholder="1000字以内" 
              rows="15"
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
            v-model="list.tag_names"
            label="name" 
            :options="options" 
            :reduce="tags => tags.name"
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
            @click="createlist"
          >
            登録
          </button>
        </div>
        <div class="control">
          <button class="button is-light">
            キャンセル
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import SearchList from './conponents/youtube/SearchList.vue'
import { useForm, Field } from 'vee-validate';
import { object, string } from 'yup';

export default {
  name: "ListNew",
  components: {
    SearchList,
    Field,
  },
  data() {
    return {
      newlist: [],
      list: {
        title: '',
        playlistid: '',
        recommend: '',
        videos: '',
        tag_names: [],
      },
    }
  },
  setup() {
    const schema = object({
      title: 
        string()
        .required('必須の項目です。')
        .max(100,("${max}文字以内で入力してください")),
      recommend: 
        string()
        .required('必須の項目です。')
        .max(1000,("${min}文字以内で入力してください")),
      playlistid: 
        string()
        .required('必須の項目です。動画を選択してください。')
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
      ...mapGetters("users", ["authUser"]),
      ...mapGetters("tags", ["tags"]),
      ...mapGetters("youtube", ["videos"]),
    options:{
      get(){ return this.tags }
    }
  },
  methods: {
    ...mapActions("lists", [
      "createList",
      "createVideo",
    ]),
    ...mapActions("youtube", [
      "searchVideos",
    ]),
    ...mapActions("tags", [
      "fetchTags",
    ]),
    async createlist() {
      try {
        await
        this.searchVideos(this.list.playlistid)
        this.list.videos = this.videos
        this.createList(this.list)
        this.$router.push({ name: 'ListIndex' })
        this.$notify({
          title: "登録しました",
          text:"引き続き勉強を頑張りましょう!"
        });
      } catch (error) {
          this.$notify({
            type: "warn",
            title: "登録に失敗しました",
          });
        }
    },
    select(id) {
      this.list.playlistid = id
    },
  },
  created () {
    this.fetchTags();
  },
}
</script>
