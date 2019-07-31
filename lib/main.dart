import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/screens/screens.dart';
import 'package:todo/constants/routes.dart';
import 'package:todo/constants/theme.dart';
import 'package:todo/repositories/repositories.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  // BlocSupervisor oversees Blocs and delegates to BlocDelegate.
  // We can set the BlocSupervisor's delegate to an instance of `SimpleBlocDelegate`.
  // This will allow us to handle all transitions and errors in SimpleBlocDelegate.
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ExpensesBloc>(
          builder: (context) {
            return ExpensesBloc(
              expensesRepository: ExpensesRepository(
                '__expenses__',
                getApplicationDocumentsDirectory,
              ),
            );
          },
        ),
        BlocProvider<IncomesBloc>(
          builder: (context) {
            return IncomesBloc(
              incomesRepository: IncomesRepository(
                '__incomes__',
                getApplicationDocumentsDirectory,
              ),
            );
          },
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: AppTheme.theme,
      routes: {
        Routes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                builder: (context) => TabBloc(),
              ),
            ],
            child: HomeScreen(),
          );
        },
        Routes.addExpense: (context) {
          return ExpensesFormScreen(
            isEditing: false,
          );
        },
        Routes.editExpense: (context) {
          return ExpensesFormScreen(
            isEditing: true,
          );
        },
        Routes.addIncome: (context) {
          return IncomesFormScreen(
            isEditing: false,
          );
        },
        Routes.editIncome: (context) {
          return IncomesFormScreen(
            isEditing: true,
          );
        }
      },
    );
  }
}
