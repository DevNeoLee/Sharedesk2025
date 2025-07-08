const { environment } = require("@rails/webpacker");

const webpack = require("webpack");

// Add an additional plugin of your choosing : ProvidePlugin
environment.plugins.prepend(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.Tether": "tether",
    Popper: ["popper.js", "default"] // for Bootstrap 4
  })
);

const aliasConfig = {
    jquery: 'jquery-ui-dist/external/jquery/jquery.js',
    'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
};

environment.config.set('resolve.alias', aliasConfig);

const config = environment.toWebpackConfig();
config.resolve.alias = {
 jquery: 'jquery/src/jquery',
 'jquery-ui': 'jquery-ui-dist/jquery-ui.js' 
};

module.exports = environment;

