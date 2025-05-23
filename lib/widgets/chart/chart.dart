import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final totals = {
      Category.food: 0.0,
      Category.travel: 0.0,
      Category.leisure: 0.0,
      Category.work: 0.0,
      Category.other: 0.0,
    };

    for (final expense in expenses) {
      totals[expense.category] = totals[expense.category]! + expense.amount;
    }

    final maxAmount = totals.values.fold(0.0, (a, b) => a > b ? a : b);
    final scaledMax = (maxAmount * 1.1).clamp(10.0, double.infinity);

    final totalAmount = totals.values.reduce((a, b) => a + b);

    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color(0xFF1E2A38),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              'Total: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: totals.entries.map((entry) {
                  final amount = entry.value;
                  final fraction = scaledMax == 0 ? 0.0 : amount / scaledMax;
                  return Expanded(
                    child: ChartBar(
                      fill: fraction,
                      label: '\$${amount.toStringAsFixed(0)}',
                      icon: categoryIcons[entry.key]!,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
