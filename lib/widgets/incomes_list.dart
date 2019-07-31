import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';
import 'package:todo/models/models.dart';

// A ListItem that contains data to display a heading.
class IncomeHeadingListItem implements ListItem {
  final String heading;

  IncomeHeadingListItem(this.heading);
}

// A ListItem that contains data to display a message.
class IncomeListItem implements ListItem {
  final Income income;

  IncomeListItem(this.income);
}

class IncomesList extends StatelessWidget {
  IncomesList({@required this.incomes, Key key}) : super(key: key);

  final List<Income> incomes;

  @override
  Widget build(BuildContext context) {
    final incomesBloc = BlocProvider.of<IncomesBloc>(context);

    var catMap = new SplayTreeMap<String, List<IncomeListItem>>();
    var displayList = List<ListItem>();

    incomes.forEach((exp) {
      if (!catMap.containsKey(exp.category)) {
        catMap[exp.category] = [];
      }
      catMap[exp.category].add(IncomeListItem(exp));
    });

    catMap.forEach((cat, val) {
      displayList.add(IncomeHeadingListItem(cat));
      displayList.addAll(val);
    });

    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (BuildContext context, int index) {
        final item = displayList[index];

        if (item is IncomeHeadingListItem) {
          return IncomeHeading(heading: item.heading);
        }

        if (item is IncomeListItem) {
          return IncomeItem(
            income: item.income,
            onDismissed: (dir) {
              incomesBloc.dispatch(DeleteIncome(item.income));
              Scaffold.of(context).showSnackBar(DeleteItemSnackBar(
                name: item.income.name,
                onUndo: () => incomesBloc.dispatch(AddIncome(item.income)),
              ));
            },
            onTap: () {
              print('EDIIIIIIIIIIT INCOOOOOOOOOOOOOMEEEE');
              Navigator.pushNamed(context, Routes.editIncome,
                  arguments: item.income);
            },
          );
        }

        return null;
      },
    );
  }
}