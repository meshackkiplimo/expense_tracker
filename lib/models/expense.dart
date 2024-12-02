import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

// Date formatter
final formatter = DateFormat.yMd();

// Unique ID generator
const uuid = Uuid();

// Categories for expenses
enum Category { 
  food, 
  travel, 
  leisure, 
  work 
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  // Formatted date getter
  String get formattedDate {
    return formatter.format(date);
  }

  // Category icon getter
  IconData get categoryIcon {
    switch (category) {
      case Category.food:
        return Icons.lunch_dining;
      case Category.travel:
        return Icons.flight;
      case Category.leisure:
        return Icons.movie;
      case Category.work:
        return Icons.work;
    }
  }

  // Constructor with auto-generated unique ID
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
}