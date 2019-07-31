import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';
import 'package:todo/models/models.dart';
import 'package:todo/constants/categories.dart';

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
          var catMap = new Map<String, List<ListItem>>();
          var displayList = List<ListItem>();

          expenses.forEach((exp) {
            if (!catMap.containsKey(exp.category)) {
              catMap[exp.category] = [];
            }
            catMap[exp.category].add(ExpenseListItem(exp));
          });

          catMap.forEach((cat, val) {
            displayList.add(HeadingListItem(cat));
            displayList.addAll(val);
          });

          return ListView.builder(
            itemCount: displayList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = displayList[index];

              if (item is HeadingListItem) {
                return ExpenseHeading(heading: item.heading);
              }


              if (item is ExpenseListItem) {
                return ExpenseItem(
                  expense: item.expense,
                  onDismissed: (dir) {
                    expensesBloc.dispatch(DeleteExpense(item.expense));
                    Scaffold.of(context).showSnackBar(DeleteExpenseSnackBar(
                      expense: item.expense,
                      onUndo: () => expensesBloc.dispatch(AddExpense(item.expense)),
                    ));
                  },
                  onTap: () {
                    Navigator.pushNamed(
                        context, Routes.editExpense, arguments: item.expense);
                  },
                );
              }

              return null;
            }
          );
        }

        return Text('Expenses Not Loaded');
      },
    );
  }
}

// The base class for the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingListItem implements ListItem {
  final String heading;

  HeadingListItem(this.heading);
}

// A ListItem that contains data to display a message.
class ExpenseListItem implements ListItem {
  final Expense expense;

  ExpenseListItem(this.expense);
}