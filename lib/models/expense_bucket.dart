import 'package:expense_tracker/models/expense_model.dart';
import 'package:flutter/foundation.dart';

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenseModel,
  });

  ExpenseBucket.forCategory(List<ExpenseModel> allExpense, this.category)
      : expenseModel = allExpense
            .where((expense) => expense.category == category)
            .toList();

  final Categorys category; // Corrected the type to Categorys
  final List<ExpenseModel> expenseModel;

  double get totalExpense {
    double sum = 0;
    for (final expense in expenseModel) {
      sum += expense.amount;
    }
    return sum;
  }
}
