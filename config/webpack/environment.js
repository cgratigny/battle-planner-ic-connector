const { environment } = require('@rails/webpacker')
// const coffee = require('./loaders/coffee')
// const erb = require('./loaders/erb')

// environment.loaders.prepend('erb', erb)
// environment.loaders.prepend('coffee', coffee)

const webpack = require('webpack')

environment.plugins.prepend('Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    moment: "moment"
  })
)

// Get the actual sass-loader config
const sassLoader = environment.loaders.get('sass')
const sassLoaderConfig = sassLoader.use.find(function(element) {
  return element.loader == 'sass-loader'
})

// Use Dart-implementation of Sass (default is node-sass)
const options = sassLoaderConfig.options
options.implementation = require('sass')

module.exports = environment
