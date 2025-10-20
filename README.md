# 🏪 Basic Store - Flutter POS System

Một hệ thống Point of Sale (POS) hoàn chỉnh được xây dựng bằng Flutter, hỗ trợ quản lý cửa hàng, bán hàng, kho hàng và báo cáo chi tiết.

## ✨ Tính năng chính

### 🛒 **Hệ thống POS**
- Giao diện bán hàng trực quan với giỏ hàng
- Quét mã vạch sản phẩm
- Thanh toán đa phương thức (tiền mặt, thẻ, ví điện tử)
- Tính toán thuế VAT và phí dịch vụ
- In hóa đơn PDF
- Quản lý tiền thừa và trả lại

### 👥 **Quản lý khách hàng**
- Hồ sơ khách hàng chi tiết
- Lịch sử mua hàng
- Hệ thống điểm tích lũy (loyalty points)
- Phân loại khách hàng theo tier

### 📦 **Quản lý sản phẩm & Kho hàng**
- Danh mục sản phẩm với SKU, mã vạch
- Theo dõi tồn kho real-time
- Cảnh báo sắp hết hàng
- Điều chỉnh tồn kho với lý do
- Quản lý batch và hạn sử dụng
- Sản phẩm yêu thích và gần đây

### 🏢 **Hệ thống đa cửa hàng**
- Quản lý nhiều cửa hàng/chi nhánh
- Chuyển kho giữa các cửa hàng
- Giá sản phẩm riêng theo cửa hàng
- Báo cáo theo từng cửa hàng

### 🚚 **Quản lý nhà cung cấp**
- Danh sách nhà cung cấp
- Đơn đặt hàng (Purchase Orders)
- Nhập hàng (Goods Receipt Notes)
- Theo dõi chi phí và lợi nhuận

### 💰 **Khuyến mãi & Giảm giá**
- Giảm giá theo sản phẩm hoặc toàn đơn
- Mã coupon
- Quy tắc giảm giá phức tạp
- Happy hour pricing

### 🔄 **Trả hàng & Đổi hàng**
- Xử lý trả hàng với lý do
- Quản lý stock âm
- Audit trail cho tất cả giao dịch

### 📊 **Báo cáo & Phân tích**
- Báo cáo bán hàng theo ngày/tuần/tháng
- Top sản phẩm bán chạy
- Phân tích lợi nhuận theo sản phẩm
- Báo cáo khách hàng VIP
- Tăng trưởng doanh thu
- Xuất dữ liệu CSV/PDF

### 👤 **Quản lý người dùng**
- Hệ thống đăng nhập với roles
- Phân quyền Admin/Cashier/Manager
- Audit log cho tất cả hoạt động
- Session management

### 🌐 **Đa ngôn ngữ**
- Hỗ trợ tiếng Việt và tiếng Anh
- Chuyển đổi ngôn ngữ real-time
- Localization cho tất cả UI

### 🎨 **Giao diện người dùng**
- Material Design 3
- Dark mode / Light mode
- Responsive design
- Numeric keypad cho nhập số lượng
- Tab navigation
- Modern UI components

### 💾 **Backup & Restore**
- Xuất toàn bộ dữ liệu JSON
- Import dữ liệu từ file backup
- Chia sẻ file qua ứng dụng khác

## 🛠️ **Công nghệ sử dụng**

- **Framework**: Flutter 3.x
- **Database**: Isar (NoSQL local database)
- **State Management**: BLoC/Cubit
- **PDF Generation**: pdf package
- **Barcode Scanning**: mobile_scanner
- **File Sharing**: share_plus
- **Localization**: flutter_localizations
- **UI**: Material Design 3

## 📱 **Cài đặt & Chạy dự án**

### Yêu cầu hệ thống
- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- Android device/emulator hoặc iOS device/simulator

### Cài đặt dependencies
```bash
flutter pub get
```

### Tạo database schema
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### Chạy ứng dụng
```bash
flutter run
```

## 📁 **Cấu trúc dự án**

```
lib/
├── data/
│   ├── models/           # Isar database models
│   ├── repositories/     # Data access layer
│   └── services/         # Business logic services
├── logic/
│   └── cubits/          # BLoC state management
├── presentation/
│   ├── screens/         # UI screens
│   ├── widgets/         # Reusable UI components
│   └── dialogs/         # Modal dialogs
└── l10n/               # Localization files
```

## 🗄️ **Database Schema**

### Core Models
- **Product**: Sản phẩm với SKU, giá, tồn kho
- **Order**: Đơn hàng với items và customer
- **Customer**: Thông tin khách hàng và loyalty points
- **Payment**: Thanh toán với multiple methods
- **Store**: Thông tin cửa hàng/chi nhánh

### Advanced Models
- **StockAdjustment**: Điều chỉnh tồn kho
- **PurchaseOrder**: Đơn đặt hàng từ supplier
- **GoodsReceipt**: Nhập hàng
- **StockTransfer**: Chuyển kho giữa stores
- **Return**: Trả hàng/đổi hàng
- **AuditLog**: Nhật ký hoạt động

## 🎯 **Tính năng nổi bật**

### 1. **Smart POS Interface**
- Quick-add sản phẩm bằng SKU hoặc scan
- Numeric keypad cho quantity input
- Real-time calculation với tax và discount
- Multiple payment methods support

### 2. **Advanced Inventory Management**
- Low stock alerts
- Batch tracking với expiry dates
- Stock adjustment với audit trail
- Multi-store inventory sync

### 3. **Comprehensive Reporting**
- Sales analytics với date range
- Customer behavior analysis
- Product profitability reports
- Export to CSV/PDF

### 4. **User Experience**
- Dark/Light theme
- Multi-language support
- Favorites và recent products
- Intuitive navigation

## 🔧 **Cấu hình**

### Settings
- Store information (name, address, phone)
- Tax rates và service fees
- Currency và locale settings
- Receipt customization
- Logo và footer text

### Permissions
- Camera permission cho barcode scanning
- Storage permission cho file export
- Network permission cho future cloud sync

## 📊 **Screenshots**

*[Thêm screenshots của ứng dụng tại đây]*

## 🚀 **Roadmap**

### Đã hoàn thành ✅
- [x] Core POS functionality
- [x] Customer management
- [x] Inventory management
- [x] Multi-store support
- [x] Advanced reporting
- [x] Data export/import
- [x] User management
- [x] Localization
- [x] Dark mode

### Đang phát triển 🚧
- [ ] Cloud synchronization
- [ ] Receipt printing via Bluetooth
- [ ] Advanced analytics dashboard
- [ ] Mobile app for customers

### Kế hoạch tương lai 📋
- [ ] Web admin panel
- [ ] API integration
- [ ] Multi-tenant support
- [ ] Advanced inventory forecasting

## 🤝 **Đóng góp**

Mọi đóng góp đều được chào đón! Vui lòng:

1. Fork repository
2. Tạo feature branch
3. Commit changes
4. Push to branch
5. Tạo Pull Request

## 📄 **License**

Dự án này được phát hành dưới MIT License. Xem file `LICENSE` để biết thêm chi tiết.

## 👨‍💻 **Tác giả**

Được phát triển bởi [Tên tác giả] với sự hỗ trợ của Flutter community.

## 📞 **Liên hệ**

- Email: [email@example.com]
- GitHub: [github.com/username]
- LinkedIn: [linkedin.com/in/username]

---

**Basic Store** - Giải pháp POS toàn diện cho doanh nghiệp nhỏ và vừa! 🏪✨