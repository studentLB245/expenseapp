import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenseapp/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({
    super.key,
    required this.onSubmit,
    this.expenseToEdit,
  });

  final void Function(Expense newExpense, Expense? originalExpense) onSubmit;
  final Expense? expenseToEdit;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _customTagController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void initState() {
    super.initState();
    final expense = widget.expenseToEdit;
    if (expense != null) {
      _titleController.text = expense.title;
      _amountController.text = expense.amount.toString();
      _selectedDate = expense.date;
      _selectedCategory = expense.category;
      if (expense.category == Category.other && expense.customTag != null) {
        _customTagController.text = expense.customTag!;
      }
    }
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final title = _titleController.text.trim();

    if (title.isEmpty || enteredAmount == null || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    final expense = Expense(
      title: title,
      amount: enteredAmount,
      date: _selectedDate!,
      category: _selectedCategory,
      customTag: _selectedCategory == Category.other
          ? _customTagController.text.trim().isNotEmpty
              ? _customTagController.text.trim()
              : null
          : null,
    );

    widget.onSubmit(expense, widget.expenseToEdit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expenseToEdit != null;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '\$',
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCategory = value;
                  });
                },
                items: Category.values.map((cat) {
                  final capitalized = cat.name[0].toUpperCase() + cat.name.substring(1);
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(capitalized),
                  );
                }).toList(),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _presentDatePicker,
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : formatter.format(_selectedDate!)),
              ),
            ],
          ),
          if (_selectedCategory == Category.other)
            TextField(
              controller: _customTagController,
              decoration: const InputDecoration(labelText: 'Custom Tag'),
            ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // cancel
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpense,
                child: Text(isEditing ? 'Update' : 'Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
