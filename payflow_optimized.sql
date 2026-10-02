-- ========================================================
-- HỆ THỐNG PAYFLOW - TỐI ƯU HÓA TRUY VẤN (OPTIMIZED SCRIPT)
-- ========================================================

CREATE DATABASE IF NOT EXISTS payflow_db;
USE payflow_db;

-- 1. Tạo bảng Transactions (Mô phỏng bảng lớn)
DROP TABLE IF EXISTS Transactions;
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(15,2),
    transaction_type VARCHAR(20), -- 'DEPOSIT', 'WITHDRAW', 'TRANSFER'
    created_at DATETIME
);

-- 2. TẠO COMPOSITE INDEX ĐỂ TỐI ƯU TRUY VẤN
-- Sắp xếp thứ tự: transaction_type trước (độ phân giải thấp hơn, lọc nhanh tập dữ liệu bằng điều kiện '=', 
-- tiếp theo là created_at để hỗ trợ điều kiện khoảng thời gian 'Range').
CREATE INDEX idx_type_date ON Transactions(transaction_type, created_at);

-- ========================================================
-- KIỂM TRA BẢN KẾ HOẠCH THỰC THI (EXPLAIN) TRƯỚC KHI TỐI ƯU (LEGACY - Non-SARGable)
-- ========================================================
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND YEAR(created_at) = 2026 
  AND MONTH(created_at) = 6;

-- ========================================================
-- TRUY VẤN ĐÃ ĐƯỢC TÁI CẤU TRÚC (SARGable Query + Index Range Scan)
-- Thay thế hàm YEAR() và MONTH() bằng khoảng thời gian (>= và <)
-- ========================================================
EXPLAIN 
SELECT SUM(amount) AS total_deposit
FROM Transactions
WHERE transaction_type = 'DEPOSIT' 
  AND created_at >= '2026-06-01 00:00:00' 
  AND created_at < '2026-07-01 00:00:00';
