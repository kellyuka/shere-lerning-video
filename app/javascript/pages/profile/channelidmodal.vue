<template>
  <div class="modal is-active">
    <div class="modal-background" />
    <div class="modal-card">
      <header class="modal-card-head">
        <p class="modal-card-title">
          チャンネルIDとは
        </p>
        <button
          class="delete"
          aria-label="close"
          @click="VisibleChannelid"
        />
      </header>
      <section class="modal-card-body">
        <div class="content">
          <p>どのYouTubeチャンネルにも一意のユーザーIDとチャンネルID があり</p>
          <p>特定のアプリやサービスでチャンネルを参照するために使用されています。</p>
          <p>当サービスでは、チャンネルIDを使って登録されている再生リストを取得いたします。</p>
          <div>
            <h5>みつけかた</h5>
            <ul>
              <li>
                <a
                  href="https://www.youtube.com/"
                  rel="noopener"
                  target="_blank"
                >YouTube</a> にログインします。
              </li>
              <li>
                右上のプロフィール写真 <img
                  src="//lh3.googleusercontent.com/SaY5lqCwN7kppnS546l9ys-E2sZftTTIHjBrdV-WsGPIhGjaxcEXjfgdIfW_UNG7Sw0=w26-h36"
                  width="13"
                  height="18"
                  alt="次の操作"
                  data-mime-type="image/png"
                  data-alt-src="//lh3.googleusercontent.com/SaY5lqCwN7kppnS546l9ys-E2sZftTTIHjBrdV-WsGPIhGjaxcEXjfgdIfW_UNG7Sw0"
                > [<strong>設定</strong>] <img
                  src="//lh3.googleusercontent.com/PzFeiQQaPASuntRuvWiXoqZjQqUj0s0q0w_jI4Nx9vL6x7rGmmS9f-xQr1Kj9S91WMlm=w36-h36"
                  width="18"
                  height="18"
                  alt="設定"
                  data-mime-type="image/png"
                  data-alt-src="//lh3.googleusercontent.com/PzFeiQQaPASuntRuvWiXoqZjQqUj0s0q0w_jI4Nx9vL6x7rGmmS9f-xQr1Kj9S91WMlm"
                > をクリックします。
              </li>
              <li>左側のメニューから [<strong>詳細設定</strong>] を選択します。</li>
              <li>チャンネルのユーザーIDとチャンネルIDが表示されます。</li>
              <li>チャンネルIDをコピーし、入力してください。</li>
            </ul>
            <img src="../../../assets/images/youtube-channel-id-1.png">
          </div>
        </div>
      </section>
      <footer class="modal-card-foot">
        <button
          class="button"
          @click="VisibleChannelid"
        >
          閉じる
        </button>
      </footer>
    </div>
  </div>
</template>
<script>
export default {
  name: "Channelid",
  methods: {
    VisibleChannelid(){
      this.$emit('VisibleChannelid')
    },
  },
}
</script>
