const Product = require('../models/Item');

const getItem = async (req, res) => {
    try {
        const { search, id } = req.query
        let item = [];
        if(!!id) {
            item = await Product.findOne({_id: id})
        } else {
            if(!!search) {
                item = await Product.find({
                    $or: [
                        { name: { $regex: search, $options: 'i' } },
                    ]
                })
            } else {
                item = await Product.find({})
            }
        }
        console.log(item)
        res.status(200).json(item)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}


module.exports = { getItem }

