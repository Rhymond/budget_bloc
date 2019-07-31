import 'package:flutter/material.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants/categories.dart';

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
  String _category;
  int _amount;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);
    final Expense expense = ModalRoute.of(context).settings.arguments;

    String categoryValue = Categories.list[0];
    if (_category != null) {
      categoryValue = _category;
    } else if (isEditing && expense.category != '') {
      categoryValue = expense.category;
      _category = expense.category;
    } else {
      _category = categoryValue;
    }

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
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: "Name",
                ),
                validator: (val) {
                  return val.trim().isEmpty ? "Field is required" : null;
                },
                onSaved: (value) => _name = value,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: categoryValue,
                decoration: InputDecoration(
                  labelText: "Category",
                ),
                items: Categories.list
                    .map((v) => DropdownMenuItem(
                          child: Text(v),
                          value: v,
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: isEditing ? expense.amount.toString() : '',
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (String value) {
                  if (value.trim().isEmpty) {
                    return 'Amount is required';
                  }
                  final n = int.tryParse(value);
                  if (n == null) {
                    return '"$value" is not a valid number';
                  }
                  if (n <= 0) {
                    return 'amount must be positive';
                  }
                  return null;
                },
                onSaved: (value) => _amount = int.tryParse(value),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (isEditing) {
              expensesBloc.dispatch(UpdateExpense(Expense(_name,
                  id: expense.id, amount: _amount, category: _category)));
            } else {
              expensesBloc.dispatch(AddExpense(
                  Expense(_name, amount: _amount, category: _category)));
            }

            Navigator.pop(context);
          }
        },
        icon: Icon(isEditing ? Icons.edit : Icons.save),
        label: Text(isEditing ? 'Edit' : 'Save'),
      ),
    );
  }
}
