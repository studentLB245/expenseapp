import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemove,
    required this.onEdit,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;
  final void Function(Expense expense) onEdit;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return ExpenseItem(
          expense: expenses[index],
          onRemove: onRemove,
          onEdit: onEdit,
        );
      },
    );
  }
}
