import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onRemove,
  });

  final Expense expense;
  final void Function(Expense) onEdit;
  final void Function(Expense) onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[100],
      child: ListTile(
        leading: Icon(categoryIcons[expense.category]),
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${expense.formattedDate} • \$${expense.amount.toStringAsFixed(2)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => onEdit(expense),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => onRemove(expense),
            ),
          ],
        ),
      ),
    );
  }
}
