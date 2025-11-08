import 'package:objectbox/objectbox.dart';


enum PaymentMethod { cash, card, ewallet }

@Entity()
class Payment {
  @Id()
  int id = 0;

  @Index()
  int orderId = 0;

  @Property(type: PropertyType.byte)
  int methodValue = PaymentMethod.cash.index;

  @Transient()
  PaymentMethod get method => PaymentMethod.values[methodValue];
  set method(PaymentMethod value) => methodValue = value.index;
  double value = 0; // percent or amount depending on type
  double amount = 0;
  @Property(type: PropertyType.date)
  DateTime createdAt = DateTime.now();
}
