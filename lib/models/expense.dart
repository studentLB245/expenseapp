import 'package:flutter/material.dart';

enum Category { food, travel, leisure, work, other }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.other: Icons.label,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.customTag,
  });

  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final String? customTag;

  String get formattedDate {
    return '${date.month}/${date.day}/${date.year}';
  }
}
