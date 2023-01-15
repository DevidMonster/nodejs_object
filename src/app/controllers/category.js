const Category = require('../models/category');

const getCategory = async (req, res) => {
    try {
        const category = await Category.find({})
        console.log(category)
        res.status(200).json(category)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

module.exports = { getCategory }

