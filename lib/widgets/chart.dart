import 'package:flutter/material.dart';

// Data structure for chart
class ChartData {
  final String day;
  final double amount;

  ChartData({required this.day, required this.amount});
}

class ChartBar extends StatelessWidget {
  final double fill;
  final double amount;

  const ChartBar({
    Key? key,
    required this.fill,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}