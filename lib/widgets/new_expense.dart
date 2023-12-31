import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  // flutter doing the heavy lifting with storing values

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // you also have to tell flutter to delete the controller when the widget is no longer needed (the modal overlay)
  // it will cause memory issues and may cause the app to crash
  // so we use dispose

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // validation
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    // double: This is a data type that represents floating-point numbers, which include decimal fractions.
    // This is a method available on the double class. It attempts to convert a string into a double.
    // If the string can be successfully converted to a double, the method returns the parsed double value. If it can't be converted, it returns null.
    final invalidAmount = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!, //! to tell dart were sure it wont be null
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  // ------------------------------- Widgets for DRY Code ----------------------->
  Widget _expenseTitleWidget() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Expense Title')),
    );
  }

  Widget _expenseAmountWidget() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration:
          const InputDecoration(prefixText: '\$ ', label: Text('Amount')),
    );
  }

  Widget _datePickerWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(_selectedDate == null
            ? 'No Date Selected'
            : formatter.format(_selectedDate!)),
        IconButton(
            onPressed: _presentDatePicker,
            icon: const Icon(Icons.calendar_month))
      ],
    );
  }

  Widget _categoryPickerWidget() {
    return DropdownButton(
        value: _selectedCategory,
        items: Category.values
            .map(
              (category) => DropdownMenuItem(
                value: category,
                child: Text(
                  category.name.toUpperCase(),
                ),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value == null) {
            return;
          }
          setState(() {
            _selectedCategory = value;
          });
        });
  }
  // ---------------------------------------------------------------------------->

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, contstraints) {
      // print(contstraints.maxWidth)
      // to view all parental size constraints

      final width = contstraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: _expenseTitleWidget()),
                    const SizedBox(width: 16),
                    Expanded(child: _expenseAmountWidget()),
                  ])
                else
                  _expenseTitleWidget(),
                if (width >= 600)
                  Row(
                    children: [
                      _categoryPickerWidget(),
                      const SizedBox(width: 24),
                      Expanded(child: _datePickerWidget())
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(child: _expenseAmountWidget()),
                      const SizedBox(width: 16),
                      Expanded(child: _datePickerWidget())
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 6),
                      ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
                else
                  Row(
                    children: [
                      _categoryPickerWidget(),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 6),
                      ElevatedButton(
                        onPressed: () {
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
