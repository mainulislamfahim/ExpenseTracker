import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/widgets/expense_list.dart';
import 'package:expense_tracker/screens/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Flutter Course',
      amount: 2500,
      date: DateTime.now(),
      category: Categorys.work,
    ),
    ExpenseModel(
      title: 'Kfc',
      amount: 999,
      date: DateTime.now(),
      category: Categorys.food,
    ),
  ];

  void _openAdd() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAdd: _addExpense),
    );
  }

  void _addExpense(ExpenseModel expenseModel) {
    setState(() {
      _registeredExpenses.add(expenseModel);
    });
  }

  void _removeExpense(ExpenseModel expenseModel) {
    final expenseIndex = _registeredExpenses.indexOf(expenseModel);
    setState(() {
      _registeredExpenses.remove(expenseModel);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expenseModel);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'No Expense Found. Add New Expenses \'+\'',
        style: GoogleFonts.poppins(
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
          expenseModel: _registeredExpenses, onRemove: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAdd,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('The Chart'),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
