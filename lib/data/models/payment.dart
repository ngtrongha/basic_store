import 'package:isar/isar.dart';

part 'payment.g.dart';

enum PaymentMethod { cash, card, ewallet }

@Collection()
class Payment {
  Id id = Isar.autoIncrement;

  @Index()
  late int orderId;

  @enumerated
  late PaymentMethod method;

  late double amount;

  DateTime createdAt = DateTime.now();
}
