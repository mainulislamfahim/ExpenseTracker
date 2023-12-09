import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_bucket.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:google_fonts/google_fonts.dart';

class PieChartWidget extends StatelessWidget {
  final List<ExpenseModel> expenseModel;

  PieChartWidget({Key? key, required this.expenseModel}) : super(key: key);

  List<PieChartSectionData> pieChartSections(BuildContext context) {
    final List<ExpenseBucket> buckets = [
      ExpenseBucket.forCategory(expenseModel, Categorys.food),
      ExpenseBucket.forCategory(expenseModel, Categorys.leisure),
      ExpenseBucket.forCategory(expenseModel, Categorys.travel),
      ExpenseBucket.forCategory(expenseModel, Categorys.work),
    ];

    double totalExpense =
        buckets.fold(0.0, (sum, bucket) => sum + bucket.totalExpense);

    return buckets.map((bucket) {
      final percentage = (bucket.totalExpense / totalExpense) * 100;
      return PieChartSectionData(
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        titleStyle: GoogleFonts.poppins(
          fontSize: 16, // Adjust the font size as needed
          fontWeight: FontWeight.bold, // Make the text bold
        ), // Display percentage as label
        color: getCategoryColor(bucket.category, context),
        radius: 40, // Adjust the radius as needed
      );
    }).toList();
  }

  Color getCategoryColor(Categorys category, BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    switch (category) {
      case Categorys.food:
        return isDarkMode ? Colors.deepPurpleAccent : Colors.orange;
      case Categorys.leisure:
        return isDarkMode ? Colors.lightGreenAccent : Colors.purple;
      case Categorys.travel:
        return isDarkMode ? Colors.lightBlueAccent : Colors.green;
      case Categorys.work:
        return isDarkMode ? Colors.orangeAccent : Colors.blue;
      default:
        return isDarkMode ? Colors.grey : Colors.grey; // Default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: PieChart(
              PieChartData(
                sections: pieChartSections(context),
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                borderData: FlBorderData(
                  show: false,
                ),
                // Customize other properties of the PieChart as needed
              ),
            ),
          ),
          const SizedBox(
              width: 10), // Adjust the spacing between PieChart and labels
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabelWithDot(
                  getCategoryColor(Categorys.food, context), 'Food'),
              const SizedBox(height: 5),
              _buildLabelWithDot(
                  getCategoryColor(Categorys.leisure, context), 'Leisure'),
              const SizedBox(height: 5),
              _buildLabelWithDot(
                  getCategoryColor(Categorys.travel, context), 'Travel'),
              const SizedBox(height: 5),
              _buildLabelWithDot(
                  getCategoryColor(Categorys.work, context), 'Work'),
              const SizedBox(height: 5),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabelWithDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
