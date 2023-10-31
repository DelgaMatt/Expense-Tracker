import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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
        context: context, builder: ((context) => NewExpense(onAddExpense: _addExpense)));
  }
  // doesnt return anything so return type is void

  void _addExpense(Expense expense) {
    setState(() {
       _registeredExpenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text('The Chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
