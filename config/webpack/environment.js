const {environment} = require("@rails/webpacker");

const webpack = require("webpack");

environment.plugins.append(
    "CommonsChunkVendor",
    new webpack.optimize.CommonsChunkPlugin({
        name: "commons",
        minChunks: 2,
    })
);

module.exports = environment;
