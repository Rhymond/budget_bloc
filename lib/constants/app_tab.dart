enum AppTab { expenses, income, budget }

class AppTabUtil {
  static String getName(AppTab tab) {
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
}
