import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoading) {
            return LoadingIndicator();
          }

          if (state is ExpensesLoaded && state.expenses.length == 0) {
            return NotFound();
          }

          if (state is ExpensesLoaded && state.expenses.length != 0) {
            return ExpensesList(expenses: state.expenses);
          }

          return Text('Something went wrong');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addExpense);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
