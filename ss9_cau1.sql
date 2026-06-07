CREATE TABLE Orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

DO $$
    DECLARE
        i INT;
        v_customer_id INT;
        v_order_date DATE;
        v_total_amount NUMERIC(10, 2);
    BEGIN
        FOR i IN 1..500 LOOP
                -- 1. Tạo random customer_id từ 1 đến 50
                v_customer_id := floor(random() * 50 + 1)::INT;

                -- 2. Tạo random ngày mua hàng (Lấy ngày hiện tại lùi về ngẫu nhiên trong vòng 365 ngày qua)
                v_order_date := CURRENT_DATE - floor(random() * 365)::INT;

                -- 3. Tạo random tổng tiền từ 50,000.00 đến 5,000,000.00
                v_total_amount := (random() * 4950000 + 50000)::NUMERIC(10, 2);

                -- 4. Insert dữ liệu vào bảng
                INSERT INTO Orders (customer_id, order_date, total_amount)
                VALUES (v_customer_id, v_order_date, v_total_amount);
            END LOOP;

        RAISE NOTICE 'Đã tạo thành công 500 bản ghi dữ liệu mẫu!';
    END;
$$;

-- Tạo một B-Tree Index trên cột customer_id
CREATE INDEX idx_customer_id ON Orders(customer_id);
-- Thực hiện truy vấn SELECT * FROM Orders WHERE customer_id = X; trước và sau khi tạo Index, so sánh thời gian thực hiện
EXPLAIN ANALYZE SELECT * FROM Orders WHERE customer_id = 1;
-- Thời gian chạy trước khi đánh index là 0.119ms và sau khi đánh là 0.060ms

