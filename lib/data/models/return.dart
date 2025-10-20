import 'package:isar/isar.dart';

part 'return.g.dart';

enum ReturnReason { defective, wrongItem, customerChange, duplicate, other }

@Collection()
class Return {
  Id id = Isar.autoIncrement;

  late int originalOrderId;
  late DateTime createdAt;
  late String reason;
  late String notes;
  late double refundAmount;
  late List<ReturnItem> items;
  int? customerId;
}

@embedded
class ReturnItem {
  late int productId;
  late int quantity; // negative for returns
  late double price; // original price
  late String reason;
}
