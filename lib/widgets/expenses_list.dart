import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key key}) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);

    return BlocBuilder<ExpensesBloc, ExpensesState>(
      builder: (context, state) {
        if (state is ExpensesLoading) {
          return LoadingIndicator();
        }

        if (state is ExpensesLoaded) {
          final expenses = state.expenses;

          return ListView.builder(
            itemCount: expenses.length,
            itemBuilder: (BuildContext context, int index) {
              final expense = expenses[index];

              return ExpenseItem(
                expense: expense,
                onDismissed: (dir) {
                  expensesBloc.dispatch(DeleteExpense(expense));
                  Scaffold.of(context).showSnackBar(DeleteExpenseSnackBar(
                    expense: expense,
                    onUndo: () => expensesBloc.dispatch(AddExpense(expense)),
                  ));
                },
                onTap: () {
                  Navigator.pushNamed(context, Routes.editExpense, arguments: expense);
                },
              );
            },
          );
        }

        return Text('Expenses Not Loaded');
      },
    );
  }
}
