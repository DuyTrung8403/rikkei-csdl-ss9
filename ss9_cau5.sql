CREATE TABLE Sales
(
    sale_id     SERIAL PRIMARY KEY,
    customer_id INT,
    amount      NUMERIC(10, 2),
    sale_date   DATE
);

INSERT INTO Sales (customer_id, amount, sale_date)
VALUES (1, 150000.00, '2026-05-15'),
       (2, 300000.00, '2026-06-01'),
       (1, 250000.00, '2026-06-05'),
       (3, 400000.00, '2026-06-10'),
       (2, 120000.00, '2026-06-20'),
       (4, 500000.00, '2026-07-02');

-- Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date
-- Gọi Procedure với các ngày mẫu và hiển thị kết quả
CREATE OR REPLACE PROCEDURE calculate_total_sales(
    start_date DATE,
    end_date DATE,
    OUT total NUMERIC
)
    LANGUAGE plpgsql
AS
$$
DECLARE
BEGIN
    SELECT COALESCE(SUM(amount), 0) INTO total FROM Sales WHERE sale_date BETWEEN start_date AND end_date;
end;
$$;

DO
$$
    DECLARE
        v_total NUMERIC;
    BEGIN
        CALL calculate_total_sales('2026-06-01', '2026-06-30', v_total);
        RAISE NOTICE 'Tong doanh thu tu 01/06/2026 den 30/06/2026 la: %', v_total;
    END;
$$;