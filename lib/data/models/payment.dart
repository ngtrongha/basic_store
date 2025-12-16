enum PaymentMethod { cash, card, ewallet }

class Payment {
  int id = 0;

  int orderId = 0;

  int methodValue = PaymentMethod.cash.index;

  PaymentMethod get method => PaymentMethod.values[methodValue];
  set method(PaymentMethod value) => methodValue = value.index;
  double value = 0; // percent or amount depending on type
  double amount = 0;
  DateTime createdAt = DateTime.now();
}
