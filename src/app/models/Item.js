const mongoose = require("mongoose");

const ProductSchema = new mongoose.Schema(
  {
    cate_id: { 
        type: String,
        required: true
    },
    name: {
      type: String,
      required: true,
      min: 2,
      max: 100,
    },
    description: String,
    price: Number,
    quantity: {
        type: Number,
        default: 0,
        min: 0
    },
    view_total: {
        type: Number,
        min: 0,
        default: 0
    },
    sale_off: {
        type: Number,
        min: 0,
        max: 100,
        default: 0
    },
    images: Array,
    colors: [
        {
            color: String,
            hex_code: String
        }
    ],
    sizes: [
        {
            size: String,
            size_code: String
        }
    ],
  },
  { timestamps: true }
);

const Product = mongoose.model("Product", ProductSchema);
module.exports = Product;