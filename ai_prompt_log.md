# Nhật ký tương tác AI (AI Prompt Log)

1. **Ý nghĩa Non-SARGable và B-Tree Index:**
   - *Prompt:* "Trong MySQL, nếu tôi tạo Index cho một cột ngày tháng, nhưng trong mệnh đề WHERE tôi lại viết WHERE YEAR(col) = 2026, tại sao MySQL lại từ chối sử dụng Index và phải quét toàn bộ bảng (Full Table Scan)?"
   - *Kết quả học tập:* Hiểu rằng các hàm biến đổi dữ liệu trên cột làm mất tính đồng nhất của cấu trúc tìm kiếm nhị phân B-Tree, buộc cơ sở dữ liệu phải tính toán hàm trên từng dòng.

2. **Thứ tự cột trong Composite Index:**
   - *Prompt:* "Khi thiết kế một Composite Index trong MySQL cho cột (transaction_type, created_at), thứ tự các cột trong Index có quan trọng không? Tôi nên đặt cột nào đứng trước để có hiệu suất lọc dữ liệu (Selectivity) tốt nhất?"
   - *Kết quả học tập:* Nắm vững nguyên tắc đặt cột có độ phân giải thấp hơn (dùng phép so sánh bằng `=`) lên trước, và cột dùng cho khoảng (`Range`) đứng sau cùng.

3. **Phân tích chi tiết Extra trong EXPLAIN:**
   - *Prompt:* "Trong kết quả EXPLAIN, cột 'Extra' hiện chữ 'Using index condition' khác gì với 'Using index' (Covering Index)?"
   - *Kết quả học tập:* Phân biệt rõ cơ chế Index Condition Pushdown (ICP) giúp lọc bớt dữ liệu tại tầng Storage Engine trước khi trả về Server Layer.
