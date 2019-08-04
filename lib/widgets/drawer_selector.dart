import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/constants/app_tab.dart';

class DrawerSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

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
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                child: ListTile(
                  title: Text(
                    'BUDGET',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]..addAll(AppTab.values.map((tab) {
                return ListTile(
                  leading: Icon(AppTabUtil.getIcon(tab)),
                  title: Text(
                    AppTabUtil.getName(tab),
                  ),
                  selected: this.activeTab == tab,
                  onTap: () {
                    onTabSelected(AppTab.values[tab.index]);
                    Navigator.pop(context);
                  },
                );
              }).toList())),
      ),
    );
  }
}
