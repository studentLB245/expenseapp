import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expenses_list/expenses_list.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:expenseapp/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseOverlay({Expense? expenseToEdit}) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => NewExpense(
        onSubmit: _handleSubmit,
        expenseToEdit: expenseToEdit,
      ),
    );
  }

  void _handleSubmit(Expense newExpense, Expense? originalExpense) {
    setState(() {
      if (originalExpense != null) {
        final index = _registeredExpenses.indexOf(originalExpense);
        if (index != -1) {
          _registeredExpenses[index] = newExpense;
        }
      } else {
        final exists = _registeredExpenses.any((e) =>
            e.title == newExpense.title &&
            e.amount == newExpense.amount &&
            e.date == newExpense.date);
        if (!exists) {
          _registeredExpenses.add(newExpense);
        }
      }
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
  }

  void _editExpense(Expense expense) {
    _openAddExpenseOverlay(expenseToEdit: expense);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        backgroundColor: Colors.tealAccent.shade200,
        child: const Icon(Icons.add),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 9,
            child: Chart(expenses: _registeredExpenses),
          ),
          Expanded(
            flex: 3,
            child: _registeredExpenses.isEmpty
                ? const Center(
                    child: Text(
                      'No expenses yet. Add some!',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ExpensesList(
                    expenses: _registeredExpenses,
                    onRemove: _removeExpense,
                    onEdit: _editExpense,
                  ),
          ),
        ],
      ),
    );
  }
}
