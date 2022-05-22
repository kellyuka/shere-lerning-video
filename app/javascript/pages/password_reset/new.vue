<template>
  <section class="hero is-large">
    <div class="hero-body">
      <div class="container has-text-centered">
        <div class="column is-6 is-offset-3">
          <h3 class="title has-text-danger">
            Reset your password
          </h3>
          <hr class="login-hr">
          <div class="box has-background-light has-text-centered">
            <div v-show="send">
              <h3 class="mb-5 is-size-5 has-text-weight-bold">
                メールアドレスを入力してください
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
                <p class="help is-danger">
                  {{ errors.email }}
                </p>
              </div>
              <button 
                class="button is-primary"
                :disabled="!meta.valid"
                @click="Passwordreset"
              >
                送信
              </button>
            </div>
            <div v-show="sended">
              <div class="field">
                <h3 class="mb-5 is-size-5 has-text-weight-bold">
                  パスワード再設定メールを送信しました
                </h3>
                <p>{{ user.email }}へパスワード再設定メールを送信しました。</p>
                <p>しばらくしてもメールが届かない場合は、迷惑メールフォルダをご確認ください。</p>
              </div>
            </div>
          </div>
          <router-link
            :to="{ name: 'ListIndex' }"
          >
            トップページへ
          </router-link>
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
  name: "PasswordresetNew",
  components: {
    Field,
  },
  data() {
    return {
      send : true,
      sended : false,
    }
  },
  setup() {
    const user = {
      email: "",
    }
    const schema = object({
      email: 
        string()
        .required('必須の項目です')
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
  methods: {
    ...mapActions("passwordresets", [
      "createPasswordReset",
    ]),
    async Passwordreset() {
      try {
        await this.createPasswordReset(this.user);
        this.send = false
        this.sended = true
      } catch (error) {
        this.$notify({
          type: "warn",
          title: "送信に失敗しました",
        });
        console.log(error)
      }
    }  
  }
}
</script>
