import 'package:uuid/uuid.dart';

// giving us the opportunity to generate unique id's
const uuid = Uuid();

enum Category { food, travel, leisure, work }

// allows us to create a custom Type that is of predefined values
// These aren't stored necessarily as string values but as a blanket value
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  // will generate a String id - this is called an initializer list.
  //can init class properties with values that are NOT recieved as constructor function arguments

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}
