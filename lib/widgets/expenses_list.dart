import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expense_item.dart';

import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Dismissible(
          // Dismissible is helping us delete an expense by swiping right to left
          key: ValueKey(expenses[i]),
          // creates a key value that can be set for this key parameter
          onDismissed: (direction) {
            onRemoveExpense(expenses[i]);
          },
          child: ExpenseItem(expenses[i])),
      // will create a scrollable list and create items as items are visible or are about to be
    );
  }
}
