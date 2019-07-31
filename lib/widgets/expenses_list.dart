import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';
import 'package:todo/models/models.dart';


class ExpenseHeadingListItem implements ListItem {
  final String heading;

  ExpenseHeadingListItem(this.heading);
}

class ExpenseListItem implements ListItem {
  final Expense expense;

  ExpenseListItem(this.expense);
}

class ExpensesList extends StatelessWidget {
  ExpensesList({@required this.expenses, Key key}) : super(key: key);

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);

    var catMap = new SplayTreeMap<String, List<ListItem>>();
    var displayList = List<ListItem>();

    expenses.forEach((exp) {
      if (!catMap.containsKey(exp.category)) {
        catMap[exp.category] = [];
      }
      catMap[exp.category].add(ExpenseListItem(exp));
    });

    catMap.forEach((cat, val) {
      displayList.add(ExpenseHeadingListItem(cat));
      displayList.addAll(val);
    });

    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = displayList[index];

        if (item is ExpenseHeadingListItem) {
          return ExpenseHeading(heading: item.heading);
        }

        if (item is ExpenseListItem) {
          return ExpenseItem(
            expense: item.expense,
            onDismissed: (dir) {
              expensesBloc.dispatch(DeleteExpense(item.expense));
              Scaffold.of(context).showSnackBar(DeleteItemSnackBar(
                name: item.expense.name,
                onUndo: () => expensesBloc.dispatch(AddExpense(item.expense)),
              ));
            },
            onTap: () {
              Navigator.pushNamed(context, Routes.editExpense,
                  arguments: item.expense);
            },
          );
        }

        return null;
      },
    );
  }
}