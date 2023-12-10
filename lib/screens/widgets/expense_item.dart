import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/screens/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseModel, {super.key});
  final ExpenseModel expenseModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseModel.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('${expenseModel.amount.toStringAsFixed(2)} Tk'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenseModel.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expenseModel.formattedDate),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
