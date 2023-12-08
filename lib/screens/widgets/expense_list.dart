import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenseModel, required this.onRemove});
  final List<ExpenseModel> expenseModel;

  final void Function(ExpenseModel expenseModel) onRemove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenseModel.length,
      itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenseModel[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          onDismissed: (direction) {
            onRemove(expenseModel[index]);
          },
          child: ExpenseItem(expenseModel[index])),
    );
  }
}
