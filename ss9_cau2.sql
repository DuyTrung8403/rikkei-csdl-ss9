CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY ,
    email VARCHAR(100),
    username VARCHAR (100)
);

INSERT INTO Users (email, username)
VALUES
    ('example@example.com', 'user_example'),
    ('nguyenvana@gmail.com', 'nguyenvana'),
    ('tran_thi_b@yahoo.com', 'tranb99'),
    ('le_van_c@outlook.com', 'lec_coder'),
    ('hoang_d@gmail.com', 'hoangd88');

-- 1.Tạo Hash Index trên cột email
CREATE INDEX idx_email ON Users USING hash(email);
-- 2.Viết truy vấn SELECT * FROM Users WHERE email = 'example@example.com'; và kiểm tra kế hoạch thực hiện bằng EXPLAIN
EXPLAIN ANALYZE SELECT * FROM Users WHERE email = 'example@example.com';
--- trước khi đánh index thời gian thực thi là 0.030, sau khi tạo index thời gian là 0.026ms