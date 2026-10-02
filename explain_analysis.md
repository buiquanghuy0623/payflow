# Phân tích Hiệu năng (EXPLAIN Comparison)

- **Trước khi tối ưu (Legacy Query):**
  - Cột `type`: Nhận giá trị `ALL`, chỉ ra hiện tượng **Full Table Scan** (quét toàn bộ bảng).
  - Cột `key`: Trả về `NULL` do việc bao bọc cột `created_at` trong hàm `YEAR()` và `MONTH()` làm mất tính **SARGable**, vô hiệu hóa toàn bộ cấu trúc Index.
  - Cột `rows`: Phải duyệt qua toàn bộ hàng triệu bản ghi, gây nghẽn CPU và Table Lock.

- **Sau khi tối ưu (Optimized Query):**
  - Cột `type`: Chuyển thành `range`, cho thấy MySQL thực hiện **Index Range Scan** trên cây B-Tree hiệu quả.
  - Cột `key`: Hiển thị chính xác Composite Index `idx_type_date`.
  - Cột `rows`: Giảm thiểu tối đa số lượng dòng cần quét, giúp thời gian truy vấn rút ngắn từ 45 giây xuống chưa tới vài mili-giây, ngăn chặn hoàn toàn lỗi Timeout.
