const mongoose = require("mongoose");

const BannerSchema = new mongoose.Schema(
  {
    image: String,
    title: {
        type: String,
        required: true
    },
    subTitle: {
        type: String,
        required: true
    },
    btnText: {
        type: String,
        required: true
    },
    navLink: String,
    color: {
        type: String,
        required: true
    },
    background: {
        type: String,
        required: true
    }
  },
);

const Banner = mongoose.model("Banner", BannerSchema);
module.exports = Banner;