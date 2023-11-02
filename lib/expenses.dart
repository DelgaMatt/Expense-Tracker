import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Gas",
        amount: 60,
        date: DateTime.now(),
        category: Category.travel),
    Expense(
        title: "Cinema",
        amount: 15,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: "Tacos",
        amount: 25,
        date: DateTime.now(),
        category: Category.food)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: ((context) => NewExpense(onAddExpense: _addExpense)));
  }
  // doesnt return anything so return type is void

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    // setState to update UI
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    // clears any info messages i might still have on the screen
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Expense Removed'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width ;

    Widget mainContent = const Center(
      child: Text('No Expenses Found'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600 
      ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          )
        ],
        )
      : Row(children: [
          Expanded(
            child: Chart(expenses: _registeredExpenses),
          ),
          // Expanded constraints the child (Chart) to only take as much width as available in the Row after sizing the other children of the Row
          Expanded(
            child: mainContent,
          )
        ],
        )
    );
  }
}
