import 'package:expenses_tracker/module/expense.dart';
import 'package:expenses_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.onRemoveExpense});

  final List<Expense> expense;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(context) {
    return ListView.builder(
        itemCount: expense.length,
        itemBuilder: ((context, index) => Dismissible(
            key: ValueKey(expense[index]),
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.7),
                margin: Theme.of(context).cardTheme.margin),
            onDismissed: (direction) => onRemoveExpense(expense[index]),
            child: ExpensesItem(expense[index]))));
  }
}
