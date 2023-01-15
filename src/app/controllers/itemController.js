const Product = require('../models/Item');

const getItem = async (req, res) => {
    try {
        const { search } = req.query

        const user = await Product.find({
            $or: [
                { name: { $regex: search, $options: 'i' } },
            ]
        })
        console.log(user)
        res.status(200).json(user)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

module.exports = { getItem }

