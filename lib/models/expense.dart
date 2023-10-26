import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
// defines how we're formatting date with the intl package

// giving us the opportunity to generate unique id's
const uuid = Uuid();

enum Category { food, travel, leisure, work }

// allows us to create a custom Type that is of predefined values
// These aren't stored necessarily as string values but as a blanket value
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.computer
};

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

  String get formattedDate {
    return formatter.format(date);
  }
}
