CREATE TABLE products
(
    product_id     SERIAL PRIMARY KEY,
    category_id    INT,
    price          NUMERIC(10, 2),
    stock_quantity INT
);



-- Tạo Clustered Index trên cột category_id
CREATE INDEX idx_category ON products(category_id);
CLUSTER products USING idx_category;

-- Tạo Non-clustered Index trên cột price
CREATE INDEX idx_price ON products(price);

-- Thực hiện truy vấn SELECT * FROM Products WHERE category_id = X ORDER BY price; và giải thích cách Index hỗ trợ tối ưu
SELECT * FROM products WHERE category_id = 1 ORDER BY product_id;
/*
 với cluster index hỗ trợ sắp xep category_id = 1 thanh 1 khối, khi đó gặp mệnh đề
WHERE category_id sẽ giúp tìm đến sản phẩm đầu tiên thuoc menh de sau đó chỉ việc đọc một mạch các ô nhớ liền kề cho đến khi hết danh mục số 1
 */
