import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function(Expense) onDeleteExpense;

  const ExpenseList({
    Key? key,
    required this.expenses,
    required this.onDeleteExpense,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(expenses[index].id),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 40,
            ),
            alignment: Alignment.centerRight,
          ),
          onDismissed: (direction) {
            onDeleteExpense(expenses[index]);
          },
          child: ExpenseItem(expense: expenses[index]),
        ),
      ),
    );
  }
}