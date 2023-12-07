import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenseModel});
  final List<ExpenseModel> expenseModel;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseModel.length,
      itemBuilder: (ctx, index) => ExpenseItem(expenseModel[index]),
    );
  }
}
