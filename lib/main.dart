import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this import
import 'models/expense.dart';
import 'widgets/expense_list.dart';
import 'widgets/new_expense.dart';
import 'widgets/chart.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          secondary: Colors.amber,
        ),
        fontFamily: 'Quicksand',
      ),
      home: ExpenseScreen(),
    );
  }
}

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState(); // Corrected this line
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<Expense> _userExpenses = [];

  // Get expenses from the last 7 days
  List<Expense> get _recentExpenses {
    return _userExpenses.where((expense) {
      return expense.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  // Method to add a new expense
  void _addNewExpense(
      String title, double amount, DateTime selectedDate, Category category) {
    final newExpense = Expense(
      title: title,
      amount: amount,
      date: selectedDate,
      category: category,
    );

    setState(() {
      _userExpenses.add(newExpense);
    });
  }

  // Method to delete an expense
  void _deleteExpense(Expense expense) {
    final expenseIndex = _userExpenses.indexOf(expense);
    
    setState(() {
      _userExpenses.remove(expense);
    });

    // Optional: Add undo functionality
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _userExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  // Method to show add expense bottom sheet
  void _startAddNewExpense(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) {
        return NewExpense(onAddExpense: _addNewExpense);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewExpense(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(recentExpenses: _recentExpenses),
          ExpenseList(
            expenses: _userExpenses,
            onDeleteExpense: _deleteExpense,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewExpense(context),
        child: Icon(Icons.add),
      ),
    );
  }
  
  Chart({required List<Expense> recentExpenses}) {}
}