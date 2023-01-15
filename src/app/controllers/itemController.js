const Product = require('../models/Item');

const getItem = async (req, res) => {
    try {
        const { search } = req.query
        let user = [];
        if(!!search) {
            user = await Product.find({
                $or: [
                    { name: { $regex: search, $options: 'i' } },
                ]
            })
        } else {
            user = await Product.find({})
        }
        console.log(user)
        res.status(200).json(user)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

module.exports = { getItem }

