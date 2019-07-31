import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:todo/constants/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';

class IncomesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IncomesBloc, IncomesState>(
        builder: (context, state) {
          if (state is IncomesLoading) {
            return LoadingIndicator();
          }

          if (state is IncomesLoaded && state.incomes.length == 0) {
            return NotFound();
          }

          if (state is IncomesLoaded && state.incomes.length != 0) {
            return IncomesList(incomes: state.incomes);
          }

          return Text('Something went wrong');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addIncome);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
