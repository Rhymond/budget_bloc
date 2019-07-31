import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/models.dart';
import 'package:money/money.dart';

class IncomeItem extends StatelessWidget {
  final Income income;
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;

  IncomeItem({
    Key key,
    @required this.income,
    @required this.onDismissed,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__todo_item_${income.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        title: Hero(
          tag: '${income.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              income.name,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
        onTap: onTap,
        trailing: Text(Money(income.amount, Currency('USD')).toString()),
      ),
    );
  }
}
