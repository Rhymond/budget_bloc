import 'package:flutter/material.dart';

enum AppTab { expenses, income, savings, budget }

class AppTabUtil {
  static String getName(AppTab tab) {
    switch (tab) {
      case AppTab.savings:
        return 'Savings';
      case AppTab.budget:
        return 'Budget';
      case AppTab.income:
        return 'Income';
      case AppTab.expenses:
        return 'Expenses';
    }

    return '';
  }

  static IconData getIcon(AppTab tab) {
    switch (tab) {
      case AppTab.savings:
        return Icons.opacity;
      case AppTab.budget:
        return Icons.card_giftcard;
      case AppTab.income:
        return Icons.credit_card;
      case AppTab.expenses:
        return Icons.money_off;
    }

    return Icons.not_interested;
  }
}
