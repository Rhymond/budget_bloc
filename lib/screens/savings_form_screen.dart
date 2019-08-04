import 'package:flutter/material.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money/money.dart';

class SavingsFormScreen extends StatefulWidget {
  SavingsFormScreen({Key key, @required this.savings}) : super(key: key);

  final Savings savings;

  @override
  _SavingsFormScreenState createState() => _SavingsFormScreenState();
}

class _SavingsFormScreenState extends State<SavingsFormScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Savings get savings => widget.savings;
  int _percentage;

  @override
  Widget build(BuildContext context) {
    final savingsBloc = BlocProvider.of<SavingsBloc>(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: savings.percentage.toString(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Percentage",
                ),
                validator: (val) {
                  if (val.trim().isEmpty) {
                    return "Field is required";
                  }
                  int n = int.tryParse(val);
                  if (n >= 100 || n <= 0) {
                    return "Field value must be between 0 and 100";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                onSaved: (value) => _percentage = int.tryParse(value),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              savingsBloc.dispatch(UpdateSaving(Savings(_percentage)));
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Savings updated!'),
              ));
            }
          },
          icon: Icon(Icons.save),
          label: Text('Save')),
    );
  }
}
