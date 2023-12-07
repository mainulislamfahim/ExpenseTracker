import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Categorys { food, travel, leisure, work }

const categoryIcons = {
  Categorys.food: Icons.lunch_dining_outlined,
  Categorys.leisure: Icons.movie_creation_outlined,
  Categorys.travel: Icons.mode_of_travel_outlined,
  Categorys.work: Icons.work_history_outlined,
};

class ExpenseModel {
  ExpenseModel({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categorys category;

  String get formattedDate {
    return formatter.format(date);
  }
}
