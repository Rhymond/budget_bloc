import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExpensesList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addExpense);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
