const Item = require('../models/Item');

class ItemController {
    read(req, res) {
        console.log(req.query);
        let product_name = req.query.name;
        console.log(product_name);
        Item.readItem(product_name, (err, item) => {
            if (err) {
                return res.send(err);
            }
            res.json(item);
        });
    }

    create(req, res) {
        const createItem = new Item(req.body);
        Item.createItem(createItem, (err, item) => {
            if (err) {
                return res.send(err);
            }
            res.json(item);
        });
    }

    // update(req, res) {
    //     const newItem = new Item(req.body)
    //     Item.updateItem(newItem, (err, item) => {
    //         if(err) {
    //             return res.send(err)
    //         }
    //         res.json(item);
    //     })
    // }
}

module.exports = new ItemController();
