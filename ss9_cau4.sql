CREATE TABLE Sales
(
    sale_id     SERIAL PRIMARY KEY,
    customer_id INT,
    product_id  INT,
    sale_date   DATE,
    amount      NUMERIC(10, 2)
);

-- Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
    CREATE OR REPLACE VIEW CustomerSales AS
    SELECT customer_id, SUM(amount) total_amount FROM Sales GROUP BY customer_id;
-- Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
    SELECT * FROM CustomerSales WHERE total_amount > 1000;
-- Thử cập nhật một bản ghi qua View và quan sát kết quả
    UPDATE CustomerSales SET total_amount = 460000 WHERE customer_id = 3;
-- câu lệnh sẽ k chạy được do lỗi không thể tự động cập nhật View có chưa groupby