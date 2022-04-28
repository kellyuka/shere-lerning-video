const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')


environment.plugins.prepend(
     'VueLoaderPlugin',
     new VueLoaderPlugin()
)

environment.loaders.prepend('vue',{
     test: /\.vue$/,
     use: [{
         loader: 'vue-loader'
     }]
})

const { DefinePlugin } = require('webpack')
environment.plugins.prepend(
    'Define',
    new DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: true
    })
)
const webpack = require('webpack')
const dotenv = require('dotenv')
const dotenvFiles = [
    '.env'
]
dotenvFiles.forEach((dotenvFile) => {
    dotenv.config({ path: dotenvFile, silent: true })
})
environment.plugins.prepend('Environment',
    new webpack.EnvironmentPlugin(
        JSON.parse(JSON.stringify(process.env))
    )
)

module.exports = environment
