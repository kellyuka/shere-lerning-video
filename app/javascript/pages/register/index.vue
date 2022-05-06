<template>
  <section class="section is-medium is-relative is-clipped">
    <div
      class="is-hidden-touch has-background-danger"
      style="position: absolute; top: 0; left: 0; width: 70%; height: 100%"
    />
    <div
      class="is-hidden-desktop has-background-danger is-fullwidth"
      style="position: absolute; top: 0; left: 0; width: 100%; height: 100%"
    />
    <div class="container mx-auto is-relative">
      <div class="is-vcentered columns is-multiline">
        <div class="column is-6 is-5-desktop mb-5 mt-10">
          <div>
            <h2 class="has-text-white mb-4 is-size-1 is-size-3-mobile has-text-weight-bold">
              SHERE TECH TUBE!!
            </h2>
            <hr class="login-hr">
            <p class="has-text-white mb-0 is-size-5">
              動画で勉強したこと、共有しませんか？
            </p>
          </div>
        </div>
        <div class="column is-6 is-4-desktop mx-auto">
          <div class="box has-background-light has-text-centered">
            <span class="has-text-grey-dark">Sign Up</span>
            <h3 class="mb-5 is-size-4 has-text-weight-bold">
              Create new account
            </h3>
            <div class="field">
              <div class="control">
                <Field
                  v-slot="{ field }"
                  v-model="user.email"
                  name="email"
                >
                  <input
                    id="email"
                    name="email"
                    v-bind="field"
                    class="input" 
                    type="email" 
                    placeholder="E-mail address"
                  >
                </Field>
                <p>{{ errors.email }}</p>
              </div>
            </div>
            <div class="field">
              <div class="control">
                <Field
                  v-slot="{ field }"
                  v-model="user.name"
                  name="name"
                >
                  <input
                    id="name"
                    name="name"
                    v-bind="field"
                    class="input"
                    type="text"
                    placeholder="Name"
                  >
                </Field>
                <p>{{ errors.name }}</p>
              </div>
            </div>
            <div class="field">
              <div class="control">
                <Field
                  v-slot="{ field }"
                  v-model="user.channelid"
                  name="channelid"
                >
                  <input
                    id="channelid"
                    name="channelid"
                    v-bind="field"
                    class="input"
                    type="text"
                    placeholder="Channelid"
                  >
                </Field>
              </div>
              <p>{{ errors.channelid }}</p>
            </div>
            <div class="field">
              <div class="control">
                <Field
                  v-slot="{ field }"
                  v-model="user.password"
                  name="password"
                >
                  <input
                    id="password"
                    name="password"
                    v-bind="field"
                    class="input" 
                    type="password" 
                    placeholder="Password"
                  >
                </Field>
              </div>
              <p>{{ errors.password }}</p>
            </div>
            <div class="field">
              <div class="control">
                <Field
                  v-slot="{ field }"
                  v-model="user.password_confirmation"
                  name="password_confirmation"
                >
                  <input 
                    id="password_confirmation"
                    name="password_confirmation"
                    v-bind="field"
                    class="input" 
                    type="password" 
                    placeholder="Password Confirmation"
                  >
                </Field>
              </div>
              <p>{{ errors.password_confirmation }}</p>
            </div>
            <div class="field">
              <label class="checkbox mb-4">
                <Field
                  id="terms"
                  name="terms"
                  class="checkbox mr-2"
                  type="checkbox"
                />
                <small class="has-text-grey-dark"><a href="#">利用規約</a>、<a href="#">プライバシーポリシー</a>に同意する</small>
              </label>
              <p>{{ errors.terms }}</p>
            </div>
            <button 
              class="button is-primary py-2 is-fullwidth"  
              :disabled="!meta.valid"
              @click="register"
            >
              Get Started
            </button>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import { mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string, ref } from 'yup';
export default {
  name: "RegisterIndex",
  components: {
    Field,
  },
  setup() {
    const user = {
        name: '',
        email: '',
        channelid: '',
        password: '',
        password_confirmation: '',
        terms: false,
    }
    const schema = object({
      name: 
        string().
        required('必須の項目です。'),
      email: 
        string()
        .required('必須の項目です。')
        .email('メールアドレスの形式にして下さい。'),
      password: 
        string()
        .required('必須の項目です。')
        .min(5,("${min}文字以上で入力してください")),
      password_confirmation: 
        string()
        .required('必須の項目です。')
        .oneOf([ref("password")], "パスワードが一致しません")
        .min(5,("${min}文字以上で入力してください")),
      terms:
      string()
        .oneOf([true], "チェックをつけてください"),
    });
    const { errors, meta } = useForm({
      validationSchema: schema,
      initialValues: user,
    });

    return {
      user,
      errors,
      meta,
    };
  },
  methods: {
    ...mapActions("users", [
      "createUser",
      "loginUser",
    ]),
    async register() {
      try {
        await 
          this.createUser(this.user)
          this.$router.push({ name: 'LoginIndex' })
          this.$notify({
            title: "登録に成功しました。ログインしてください。",
          });
      } catch (error) {
        this.$notify({
          type: "warn",
          title: "登録に失敗しました",
        });
      }
    },
  }
}
</script>

<style scoped>
</style>
