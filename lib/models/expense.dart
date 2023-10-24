import 'package:uuid/uuid.dart';

// giving us the opportunity to generate unique id's
const uuid = Uuid();

class Expense {
  Expense(
      {required this.title, 
      required this.amount, 
      required this.date,
      }) : id = uuid.v4();
      // will generate a String id - this is called an initializer list.
      //can init class properties with values that are NOT recieved as constructor function arguments

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}
