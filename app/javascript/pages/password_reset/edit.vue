<template>
  <section class="hero is-large">
    <div class="hero-body">
      <div class="container has-text-centered">
        <div class="column is-4 is-offset-4">
          <h3 class="title has-text-danger">
            Change your password
          </h3>
          <hr class="login-hr">
          <div class="box has-background-light has-text-centered">
            <div v-show="change">
              <h3 class="mb-5 is-size-5 has-text-weight-bold">
                新しいパスワードを入力してください
              </h3>
              <div class="field">
                <label class="label">
                  YOUT MAIL
                </label> 
                <p v-if="this.editUser !== null">
                  {{ editUser.email }}
                </p>
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
                <p class="help is-danger">
                  {{ errors.password }}
                </p>
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
                <p class="help is-danger">
                  {{ errors.password_confirmation }}
                </p>
              </div>
              <button 
                class="button is-primary"
                :disabled="!meta.valid"
                @click="Updatepassword"
              >
                送信
              </button>
            </div>
            <div v-show="changed">
              <div class="field">
                <h3 class="mb-5 is-size-5 has-text-weight-bold">
                  パスワードを変更しました
                </h3>
              </div>
              <router-link
                :to="{ name: 'LoginIndex' }"
                class="button is-primary"
              >
                ログイン
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapGetters, mapActions } from "vuex"
import { useForm, Field } from 'vee-validate';
import { object, string, ref } from 'yup';

export default {
  name: "PasswordresetEdit",
  components: {
    Field,
  },
  props: { 
    id: {
      type: String,
      required: true
    },
  },
  data() {
    return {
      change : true,
      changed : false,
    }
  },
  setup() {
    const user = {
      password:'',
      password_confirmation: '',
    }
    const schema = object({
      password: 
        string()
        .required('必須の項目です')
        .min(5,("${min}文字以上で入力してください")),
      password_confirmation: 
        string()
        .required('必須の項目です')
        .oneOf([ref("password")], "パスワードが一致しません")
        .min(5,("${min}文字以上で入力してください")),
    })
    const { errors, meta } = useForm({
      validationSchema: schema,
      initialValues: user,
    })
    return {
      user,
      errors,
      meta,
    }
  },
  computed: {
    ...mapGetters("passwordresets", ["editUser"]),
  },
  methods: {
    ...mapActions("passwordresets", [
      "fetchEditUser","updatePasswordReset",
    ]),
    async Updatepassword() {
      try {
        await this.updatePasswordReset({ id: this.id, user: this.user });
        this.change = false
        this.changed = true
      } catch (error) {
        this.$notify({
          type: "warn",
          title: "変更に失敗しました",
        });
        console.log(error)
      }
    }  
  },
  async created () {
    await this.fetchEditUser(this.id)
    if (!this.editUser) {
      this.$router.push({ name: 'AboutIndex' })
      this.$notify({
        title: "期限切れです",
      });
    }
  },
}
</script>
