const User = require("../models/user");

const getUser = async (req, res) => {
    try {
        const user = await User.find({})
        console.log(user)
        res.status(200).json(user)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

const getUserById = async (req, res) => {
    try {
        const { id } = req.params
        console.log(id)
        const user = await User.findById(id)
        console.log(user)
        res.status(200).json(user)
    } catch(err) {
        res.status(404).json({message: err.message})
    }
}

module.exports = { getUser, getUserById }