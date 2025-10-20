<!-- ff7b6874-5bc5-4f44-8857-695f1c6c5c59 68a9eefc-cec5-4dcb-ab1a-a68e7172a5da -->
# Kế hoạch khởi tạo Flutter POS (BLoC + Isar)

## 1) Cập nhật dependencies và tooling

- Thêm các gói cần thiết vào `pubspec.yaml` theo Flutter stable hiện tại (Dart 3.x). Sử dụng lệnh để auto-chọn phiên bản ổn định tương thích:
  - `flutter pub add flutter_bloc isar isar_flutter_libs mobile_scanner pdf printing share_plus path_provider`
  - `flutter pub add -d isar_generator build_runner`
- Ghi chú: `isar` v3 không hỗ trợ web; mobile/desktop OK. Sẽ cố định generator cùng major của `isar`.

## 2) Cấu trúc thư mục

Tạo cấu trúc phân tầng rõ ràng giữa data / logic / presentation, bao gồm thư mục `presentation/dialogs` để quản lý dialog [[memory:4168842]].

```
lib/
  data/
    models/                # Isar schemas
      product.dart
      order.dart
    repositories/
      product_repository.dart
      order_repository.dart
    services/
      database_service.dart # mở/giữ Isar instance (singleton)
  logic/
    cubits/
      pos_cubit/
        pos_cubit.dart
        pos_state.dart
    blocs/
      # (chuẩn bị chỗ cho các BLoC khác nếu cần)
  presentation/
    screens/
      product_list_screen.dart
      pos_screen.dart
    widgets/
      product_card.dart
      currency_text_field.dart
    dialogs/
      add_product_dialog.dart
  main.dart
```

## 3) Models (Isar schemas)

- `data/models/product.dart`: `@Collection()` với các trường: `Id id`, `String name`, `@Index() String sku`, `double costPrice`, `double salePrice`, `int stock`. Thêm `part 'product.g.dart';`.
- `data/models/order.dart`:
  - `@Collection()` `Order` với: `Id id`, `DateTime createdAt`, `double totalAmount`, `int? customerId`, `List<OrderItem> items`.
  - `@embedded` `OrderItem` với: `int productId`, `int quantity`, `double price`.
  - Thêm `part 'order.g.dart';`.

## 4) Database Service (Isar)

- `data/services/database_service.dart`: lớp `DatabaseService` (singleton) có `Future<void> init()` để mở Isar với schemas `[ProductSchema, OrderSchema]`, và thuộc tính `Isar isar` public getter.

## 5) Repositories

- `data/repositories/product_repository.dart`: CRUD sản phẩm, search theo `sku` (đã index), pagination cơ bản.
- `data/repositories/order_repository.dart`: Tạo đơn hàng từ giỏ, lưu `Order` và cập nhật tồn kho an toàn trong transaction.

## 6) State management (BLoC/Cubit)

- `logic/cubits/pos_cubit/pos_state.dart`: chứa `List<OrderItem> cartItems`, `double totalAmount`.
- `logic/cubits/pos_cubit/pos_cubit.dart`:
  - `addProduct(Product product)`, `removeProduct(int productId)`, `updateQuantity(int productId, int newQuantity)`, `clearCart()`; luôn tính lại `totalAmount`.

## 7) UI cơ bản

- `presentation/screens/product_list_screen.dart`:
  - `AppBar`: "Quản lý Sản phẩm", `IconButton(Icons.add)` điều hướng đến thêm mới.
  - `ListView.builder` hiển thị danh sách (mock ban đầu).
  - `ListTile` hiển thị `name` và `salePrice`.
- Tạo `presentation/widgets/product_card.dart`: Card chi tiết (tên, SKU bên trái; giá bán, tồn kho bên phải).
- `presentation/widgets/currency_text_field.dart`: `TextFormField` nhập giá với `labelText: 'Giá bán'`, `prefixText: 'đ'`, `keyboardType: TextInputType.number`.
- `presentation/screens/pos_screen.dart`: bọc `Scaffold` bằng `BlocProvider`, `BlocBuilder<PosCubit, PosState>` để render giỏ; nút 'Thêm' gọi `context.read<PosCubit>().addProduct(...)`.

## 8) PDF + Share tích hợp

- Utility `lib/data/services/invoice_service.dart`:
  - `Future<Uint8List> generateInvoicePdf(Order order)` dùng `pdf`/`pw.Document` tạo hóa đơn: tiêu đề tên cửa hàng (đọc từ repository cài đặt tạm thời hoặc hằng số), bảng liệt kê items (tên/qty/đơn giá/thành tiền), tổng tiền cuối.
  - Thêm hàm lưu tạm bằng `path_provider` -> `hoa_don_${order.id}.pdf` và chia sẻ qua `share_plus`.

## 9) Build codegen và wiring

- Chạy `dart run build_runner build --delete-conflicting-outputs` để sinh `*.g.dart`.
- Khởi tạo `DatabaseService.init()` trong `main.dart` trước khi chạy app; cung cấp repositories qua providers nếu cần.

## 10) Kiểm thử nhanh

- Seed vài `Product` mẫu nếu DB trống.
- Thử tạo `Order` từ `PosCubit` và xuất PDF, chia sẻ file.

### To-dos

- [ ] Thêm dependencies và dev_dependencies bằng flutter pub add
- [ ] Tạo cấu trúc thư mục data/logic/presentation và dialogs
- [ ] Tạo models Isar Product và Order + OrderItem
- [ ] Tạo DatabaseService singleton mở Isar
- [ ] Thêm ProductRepository và OrderRepository
- [ ] Tạo PosCubit/PosState quản lý giỏ và tổng tiền
- [ ] Tạo ProductListScreen, PosScreen và widgets cần thiết
- [ ] Viết InvoiceService tạo PDF, lưu tạm, chia sẻ
- [ ] Khởi tạo DB trong main, chạy build_runner
- [ ] Tìm kiếm Model AI có thể chạy local hỗ trợ ứng dụng