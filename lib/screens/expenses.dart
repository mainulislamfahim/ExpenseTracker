import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/widgets/chart/chart.dart';
import 'package:expense_tracker/screens/widgets/expense_list.dart';
import 'package:expense_tracker/screens/widgets/new_expense.dart';
import 'package:expense_tracker/screens/widgets/pieChart/PieChartWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  bool usePieChart = true; // Initial value
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
        content: Text(
          'Expense Deleted',
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
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
        title: Text(
          'Expense Tracker',
          style: GoogleFonts.poppins(
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAdd,
            icon: const Icon(
              Icons.add,
              size: 26,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          usePieChart
              ? PieChartWidget(expenseModel: _registeredExpenses)
              : Chart(expenseModel: _registeredExpenses),
          Switch(
            value: usePieChart,
            onChanged: (value) {
              setState(() {
                usePieChart = value;
              });
            },
          ),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
