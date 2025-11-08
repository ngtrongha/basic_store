import 'package:objectbox/objectbox.dart';


@Entity()
class Customer {
  @Id()
  int id = 0;

  @Index()
  String name = '';

  @Index()
  @Unique(onConflict: ConflictStrategy.replace)
  String? phone;

  @Index()
  @Unique()
  String? email;

  String? tier; // e.g., Bronze/Silver/Gold

  int points = 0;
}
