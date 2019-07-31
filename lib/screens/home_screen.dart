import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/app_tab.dart';
import 'package:todo/screens/screens.dart';

class HomeScreen extends StatelessWidget {
  Widget _getBody(context, AppTab activeTab) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);
    final incomesBloc = BlocProvider.of<IncomesBloc>(context);

    switch (activeTab) {
      case AppTab.expenses:
        {
          expensesBloc.dispatch(LoadExpenses());
          return ExpensesScreen();
        }

      case AppTab.income:
        {
          incomesBloc.dispatch(LoadIncomes());
          return IncomesScreen();
        }

      case AppTab.budget:
        {
          return Text('Whut??');
        }
    }

    return Text('Whut??');
  }

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBloc>(context);
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          body: _getBody(context, activeTab),
          appBar: AppBar(
            title: Text(AppTabUtil.getName(activeTab)),
          ),
          drawer: DrawerSelector(
            activeTab: activeTab,
            onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab)),
          ),
        );
      },
    );
  }
}
