import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/models.dart';
import 'package:money/money.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;

  ExpenseItem({
    Key key,
    @required this.expense,
    @required this.onDismissed,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${expense.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        title: Hero(
          tag: '${expense.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              expense.name,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        onTap: onTap,
        trailing: Text(Money(expense.amount, Currency('USD')).toString()),
      ),
    );
  }
}
