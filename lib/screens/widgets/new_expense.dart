import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense_model.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAdd});

  final void Function(ExpenseModel expenseModel) onAdd;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? selectDate;
  Categorys _selectedCategory = Categorys.leisure;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectDate = pickDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Invalid Input',
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
          ),
          content: Text(
            'Please Make Sure valid title, amount, date and catagory was entered.',
            style: GoogleFonts.poppins(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'okay',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAdd(
      ExpenseModel(
          title: _titleController.text,
          amount: enteredAmount,
          date: selectDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  String toCamelCase(String input) {
    return input.replaceAllMapped(
      RegExp(r'_\w|(\b\w)'),
      (match) => match.group(0)!.toUpperCase(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          Title(
            color: ThemeData().cardColor,
            child: Text(
              'Add New Expense',
              style: GoogleFonts.poppins(
                fontSize: 20,
              ),
            ),
          ),
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text(
                'Title',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffixText: 'Tk',
                    label: Text(
                      'Amount',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      selectDate == null
                          ? 'Select Date'
                          : formatter.format(selectDate!),
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors
                        .white, // Set the background color for the dropdown menu
                  ),
                  child: DropdownButton<Categorys>(
                    alignment: Alignment.center,
                    elevation: 10,
                    value: _selectedCategory,
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    underline: Container(), // Remove the default underline
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.black),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                    selectedItemBuilder: (BuildContext context) {
                      return Categorys.values.map<Widget>((Categorys category) {
                        return Row(
                          children: [
                            Icon(categoryIcons[category]),
                            const SizedBox(width: 5),
                            Text(
                              toCamelCase(category.name.toString()),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        );
                      }).toList();
                    },
                    items: Categorys.values.map((Categorys category) {
                      return DropdownMenuItem<Categorys>(
                        value: category,
                        child: Text(
                          toCamelCase(category.name.toString()),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.resolveWith<double>(
                        (Set<MaterialState> states) {
                      return states.contains(MaterialState.hovered)
                          ? 10
                          : 0; // Adjust the elevation for hover effect
                    }),
                    side: MaterialStateProperty.all(const BorderSide(
                        color: Colors.black)), // Outline border
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Save Expense',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
