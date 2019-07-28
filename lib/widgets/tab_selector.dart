import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:todo/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  String _getTitle(AppTab tab) {
    switch (tab) {
      case AppTab.budget:
        return 'Budget';
      case AppTab.income:
        return 'Income';
      case AppTab.expenses:
        return 'Expenses';
    }

    return '';
  }

  IconData _getIcon(AppTab tab) {
    switch (tab) {
      case AppTab.budget:
        return Icons.list;
      case AppTab.income:
        return Icons.adjust;
      case AppTab.expenses:
        return Icons.ac_unit;
    }

    return Icons.stop;
  }

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: ArchSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(_getIcon(tab)),
          title: Text(_getTitle(tab)),
        );
      }).toList(),
    );
  }
}
