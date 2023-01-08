'Item strict';

const Item = function (item) {
    this.id = item.id;
    this.cate_id = item.cate_id;
    this.name = item.name;
    this.description = item.description;
    this.price = item.price;
    this.images = item.images;
    this.colors = item.colors;
    this.size = item.size;
    this.view_total = item.view_total;
    this.sale_off = item.sale_off;
    this.create_at = new Date();
};

Item.readItem = function (product_name, result) {
    let search = '';
    console.log(product_name);
    if (product_name !== undefined) {
        search = `having p.name like '%${product_name}%'`;
    }
    console.log(search);
    connection.query(
        `SELECT p.*, GROUP_CONCAT(DISTINCT i.image) AS images, GROUP_CONCAT(DISTINCT c.name) AS colors, GROUP_CONCAT(DISTINCT s.name) AS sizes FROM products AS p LEFT JOIN product_images AS i ON p.id = i.product_id LEFT JOIN product_colors AS pc ON p.id = pc.product_id LEFT JOIN colors AS c ON pc.color_id = c.id LEFT JOIN product_sizes AS ps ON p.id = ps.product_id LEFT JOIN sizes AS s ON ps.size_id = s.id GROUP BY p.id ${search}`,
        (err, res) => {
            if (err) {
                result(err, null);
            } else {
                result(null, res);
            }
        },
    );
};

Item.createItem = function (item, result) {
    connection.query(
        'INSERT INTO products (cate_id, description, name, price, view_total, sale_off) values (?, ?, ?, ?, ?, ?)',
        [
            item.cate_id,
            item.description,
            item.name,
            item.price,
            item.color,
            item.size,
            item.view_total,
            item.sale_off,
            item.create_at,
        ],
        (err, res) => {
            if (err) {
                result(err, null);
            } else {
                result(null, res);
            }
        },
    );
};

// Item.readItem = function (result) {
//   connection.query("SELECT * FROM products", (err, res) => {
//     if (err) {
//       result(err, null);
//     } else {
//       result(null, res);
//     }
//   })
// };

module.exports = Item;
