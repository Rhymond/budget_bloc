import 'package:flutter/material.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpensesFormScreen extends StatefulWidget {
  final bool isEditing;

  ExpensesFormScreen({
    Key key,
    @required this.isEditing,
  }) : super(key: key);

  @override
  _ExpensesFormScreenState createState() => _ExpensesFormScreenState();
}

class _ExpensesFormScreenState extends State<ExpensesFormScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name;
  int _amount;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);
    final Expense expense = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editing Expense' : 'Add Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? expense.name : '',
                autofocus: !isEditing,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: (val) {
                  return val.trim().isEmpty ? "Field is required" : null;
                },
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? expense.amount.toString() : '',
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                onSaved: (value) => _amount = int.tryParse(value),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (isEditing) {
              expensesBloc.dispatch(UpdateExpense(Expense(_name, id: expense.id, amount: _amount)));
            } else {
              expensesBloc.dispatch(AddExpense(Expense(_name, amount: _amount)));
            }

            Navigator.pop(context);
          }
        },
        icon: Icon(isEditing ? Icons.edit : Icons.save),
        label: Text(isEditing ? 'Edit' :'Save'),
      ),
    );
  }
}
