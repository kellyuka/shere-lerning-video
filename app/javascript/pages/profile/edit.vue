<template>
  <div class="box">
    <div class="field">
      <label class="label">メールアドレス</label>
      <div class="control">
        <Field
          v-slot="{ field }"
          v-model="edituser.email"
          name="email"
        >
          <input
            id="email"
            name="email"
            v-bind="field"
            class="input" 
            type="email" 
          >
        </Field>
      </div>
      <p class="help is-danger">
        {{ errors.email }}
      </p>
    </div>
    <div class="field">
      <label class="label">ユーザー名</label>
      <div class="control">
        <Field
          v-slot="{ field }"
          v-model="edituser.name"
          name="name"
        >
          <input 
            id="name"
            name="name"
            v-bind="field"
            class="input"
            type="text" 
            placeholder="30字以内"
          >
        </Field>
      </div>
      <p class="help is-danger">
        {{ errors.name }}
      </p>
    </div>
    <div class="field">
      <label class="label">
        チャンネルID
        <span
          class="icon-text"
          @click="VisibleChannelid"
        >
          <span class="icon">
            <ion-icon 
              name="help-circle" 
            />
          </span>
        </span>
      </label>
      <div class="control">
        <Field
          v-slot="{ field }"
          v-model="edituser.channelid"
          name="channelid"
        >
          <input 
            id="channelid"
            v-bind="field"
            class="input"
            type="text"
          >
        </Field>
      </div>
      <p class="help is-danger">
        {{ errors.channelid }}
      </p>
    </div>
    <div class="field">
      <label class="label">プロフィール</label>
      <div class="control">
        <Field
          v-slot="{ field }"
          v-model="edituser.profile"
          name="profile"
        >
          <textarea
            id="profile"
            name="profile"
            v-bind="field"
            class="textarea" 
            placeholder="200字以内" 
            rows="5"
          />
        </Field>
      </div>
      <p class="help is-danger">
        {{ errors.profile }}
      </p>
    </div>
    <div class="field">
      <label class="label">プロフィール画像</label>
      <div class="tile">
        <div class="file is-boxed is-danger">
          <label class="file-label">
            <Field
              class="file-input"
              type="file"
              name="avatar"
              @change="handleChange"
            />
            <span class="file-cta">
              <ion-icon name="folder" />
              <span class="file-label">Choose a file…</span>
            </span>
            <span class="file-name">
              {{ filename }}
            </span>
          </label>
        </div>
        <div class="ml-4">
          <img
            v-if="edituser.avatar_url"
            :src="edituser.avatar_url"
            class="image is-128x128"
            alt="プロフィール画像"
          >
          <img
            v-else
            src="../../../assets/images/noimage.png"
            class="image is-128x128"
            alt="プロフィール画像"
          >
        </div>
      </div>
      <p class="help is-danger">
        {{ errors.avatar }}
      </p>
    </div>
    <div class="field is-grouped">
      <div class="control">
        <button
          class="button is-danger"
          :disabled="!meta.valid"
          @click="updateuser"
        >
          更新
        </button>
      </div>
    </div>
    <transition name="fade">
      <Channelid
        v-if="Channelidmodal"
        @VisibleChannelid="VisibleChannelid"
      />
    </transition>
  </div>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string, array } from 'yup';
import Channelid from './channelidmodal.vue'
export default {
  name: "ProfileEdit",
  components: {
    Field,
    Channelid,
  },
  setup() {
    const uploadAvatar = ""
    const filename = "ファイルが選択されていません"
    const schema = object({
      email: 
        string()
        .required('必須の項目です。')
        .email('メールアドレスの形式にして下さい。'),
      name: 
        string().
        required('必須の項目です。'),
      profile: 
        string()
        .max(200,("${min}文字以内で入力してください")),
      avatar:
        array()
        .nullable()
        .test("file type","ファイル形式が正しくありません", (files) => {
          let valid = true;
          if (files) {
            files.map((file) => {
              if (!["image/gif", "image/jpeg", "image/png"].includes(file.type)) {
                valid = false;
              }
            });
          }
          return valid;
        }),
    })
    const { errors, meta } = useForm({
      validationSchema: schema,
    })
    return {
      uploadAvatar,
      filename,
      errors,
      meta,
    }
  },
  data() {
    return {
      Channelidmodal: false,
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    edituser:{
      get(){
        return {
          name: this.authUser.name,
          email: this.authUser.email,
          channelid: this.authUser.channelid,
          profile: this.authUser.profile,
          avatar_url: this.authUser.avatar_url,
        }
      },
    }
  },
  methods: {
    ...mapActions("users", ["updateUser"]),
    handleChange(event) {
      this.uploadAvatar = event.target.files[0]
      if (this.uploadAvatar.name.length > 0) {
        this.filename = this.uploadAvatar.name
        this.edituser.avatar_url = URL.createObjectURL(this.uploadAvatar)
      }
    },
    async updateuser() {
      const formData = new FormData()
      formData.append("user[email]", this.edituser.email)
      formData.append("user[name]", this.edituser.name)
      formData.append("user[profile]", this.edituser.profile)
      formData.append("user[channelid]", this.edituser.channelid)
      if (this.uploadAvatar)
        formData.append("user[avatar]", this.uploadAvatar)
      try {
        await this.updateUser(formData)
        this.$router.push({ name: "ListIndex" })
        this.$notify({
          title: "編集に成功しました"
        });
      } catch (error) {
        this.$notify({
          type: "warn",
          title: "編集にに失敗しました"
        });
      }
    },
    VisibleChannelid(){
      if (this.Channelidmodal == false) {
        this.Channelidmodal = true
      } else {
        this.Channelidmodal = false
      }
    },
  }
}
</script>
<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: opacity .1s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
</style>
