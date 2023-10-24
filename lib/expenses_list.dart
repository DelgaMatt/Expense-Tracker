import 'package:expense_tracker/models/expense.dart';

import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // will create a scrollable list and create items when items are visible or are about to be
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Text(expenses[i].title),
    );
  }
}
