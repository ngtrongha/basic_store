import 'package:isar/isar.dart';
import 'payment.dart';

part 'order.g.dart';

@Collection()
class Order {
  Id id = Isar.autoIncrement;

  late DateTime createdAt;
  late double totalAmount;
  int? customerId;
  int pointsDelta = 0;

  late List<OrderItem> items;
  @ignore
  List<Payment> payments = [];
  double change = 0;
}

@embedded
class OrderItem {
  late int productId;
  late int quantity;
  late double price; // unit price at the time of sale
}
