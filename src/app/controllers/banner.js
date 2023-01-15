const Banner = require('../models/banner');

const getBanner = async (req, res) => {
    try {
        const banner = await Banner.find({})
        console.log(banner)
        res.status(200).json(banner)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

module.exports = { getBanner }

