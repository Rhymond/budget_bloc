import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/screens/screens.dart';

class SavingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SavingsBloc, SavingsState>(
        builder: (context, state) {
          if (state is SavingsLoading) {
            return LoadingIndicator();
          }

          if (state is SavingsLoaded) {
            return SavingsFormScreen(savings: state.savings);
          }

          return Text('Something went wrong');
        },
      ),
    );
  }
}
