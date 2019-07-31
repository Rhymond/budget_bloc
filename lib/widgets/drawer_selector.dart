import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/models.dart';

class DrawerSelector extends StatelessWidget {
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

  DrawerSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: AppTab.values.map((tab) {
            return ListTile(
              title: Text(AppTabUtil.getName(tab)),
              selected: this.activeTab == tab,
              onTap: () {
                onTabSelected(AppTab.values[tab.index]);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
