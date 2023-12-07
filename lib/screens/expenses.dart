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
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          Expanded(child: ExpenseList(expenseModel: _registeredExpenses)),
        ],
      ),
    );
  }
}
