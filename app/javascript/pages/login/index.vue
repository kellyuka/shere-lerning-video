<template>
  <section class="hero is-danger is-medium">
    <div class="hero-body">
      <div class="container has-text-centered">
        <div class="column is-4 is-offset-4">
          <h3 class="title has-text-white">
            Let's Login
          </h3>
          <hr class="login-hr">
          <div class="box has-background-light has-text-centered">
            <span class="has-text-grey-dark">Sign In</span>
            <h3 class="mb-5 is-size-4 has-text-weight-bold">
              Join our community
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
              </div>
              <p>{{ errors.email }}</p>
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
            <button 
              class="button is-primary mb-4 is-fullwidth"
              @click="login"
            >
              Get Started
            </button>
            <!-- <a
              class="mb-4 is-inline-block"
              href="#"
            ><small>Forgot password?</small></a> -->
            <router-link
              :to="{ name: 'RegisterIndex' }"
              class="button is-white mb-2 is-flex is-justify-content-center is-align-items-center is-fullwidth"
            >
              <span class="has-text-grey-dark">create new account!</span>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string } from 'yup';

export default {
  name: "LoginIndex",
  components: {
    Field,
  },
  setup() {
    const user = {
      email: "",
      password:"",
    }
    const schema = object({
      email: 
        string()
        .required('必須の項目です。')
        .email('メールアドレスの形式にして下さい。'),
      password: 
        string()
        .required('必須の項目です。')
        .min(5,("${min}文字以上で入力してください")),
    })
    const { errors } = useForm({
      validationSchema: schema,
      initialValues: user,
    })
    return {
      user,
      errors,
    }
  },
  methods: {
    ...mapActions("users", [
      "loginUser",
    ]),
    async login() {
      try {
        await this.loginUser(this.user);
        this.$router.push({ name: 'ListIndex' })
        this.$notify({
          title: "ログインに成功しました",
          text: "youtubeで勉強していきましょう!",
        });
      } catch (error) {
        this.$notify({
          type: "warn",
          title: "ログインに失敗しました",
          text: "メールアドレスかパスワードが間違っています",
        });
      }
    }  
  }
}
</script>
