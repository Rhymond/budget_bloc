import 'package:flutter/material.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants/categories.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

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
  static final amountController = new MoneyMaskedTextController(
    initialValue: 0,
    decimalSeparator: '.',
    thousandSeparator: '',
  );

  String _name;
  String _category;
  int _amount;

  bool get isEditing => widget.isEditing;

  @override
  void dispose() {
    amountController.updateValue(0);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expensesBloc = BlocProvider.of<ExpensesBloc>(context);
    final Expense expense = ModalRoute.of(context).settings.arguments;

    if (isEditing) {
      amountController.updateValue(expense.amount.toDouble() / 100);
    }

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
                controller: amountController,
                autocorrect: false,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (String value) {
                  if (amountController.numberValue <= 0) {
                    return 'Amount must be positive';
                  }
                  return null;
                },
                onSaved: (value) {
                  _amount = (amountController.numberValue * 100).toInt();
                },
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
