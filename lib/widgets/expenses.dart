import 'package:expenses_tracker/widgets/chart/chart.dart';
import 'package:expenses_tracker/widgets/expense_list/expense_list.dart';
import 'package:expenses_tracker/module/expense.dart';
import 'package:expenses_tracker/widgets/expense_list/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expensesList = [
    Expense(
        title: "Flutter Cource",
        amount: 12.98,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Cycling",
        amount: 11.0,
        date: DateTime.now(),
        category: Category.travel)
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              addNewExpense: addNewExpanse,
            ));
  }

  void addNewExpanse(Expense expense) {
    setState(() {
      expensesList.add(expense);
    });
  }

  void onRemoveExpanse(Expense expanse) {
    final expanseIndex = expensesList.indexOf(expanse);
    setState(() {
      expensesList.remove(expanse);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expanse is being deleted!"),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expensesList.insert(expanseIndex, expanse);
            });
          }),
    ));
  }

  @override
  Widget build(context) {
    Widget mainContent = const Center(
      child: Text("The is no any expanse.Start adding some..."),
    );

    if (expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expense: expensesList,
        onRemoveExpense: onRemoveExpanse,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(children: [
        Chart(expenses: expensesList),
        Expanded(child: mainContent)
      ]),
    );
  }
}
