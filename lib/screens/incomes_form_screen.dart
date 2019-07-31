import 'package:flutter/material.dart';
import 'package:todo/blocs/blocs.dart';
import 'package:todo/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constants/income_categories.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class IncomesFormScreen extends StatefulWidget {
  final bool isEditing;

  IncomesFormScreen({
    Key key,
    @required this.isEditing,
  }) : super(key: key);

  @override
  _IncomesFormScreenState createState() => _IncomesFormScreenState();
}

class _IncomesFormScreenState extends State<IncomesFormScreen> {
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
    final incomesBloc = BlocProvider.of<IncomesBloc>(context);
    final Income income = ModalRoute.of(context).settings.arguments;

    if (isEditing) {
      amountController.updateValue(income.amount.toDouble() / 100);
    }

    String categoryValue = IncomeCategories.list[0];
    if (_category != null) {
      categoryValue = _category;
    } else if (isEditing && income.category != '') {
      categoryValue = income.category;
      _category = income.category;
    } else {
      _category = categoryValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Income' : 'Add Income'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? income.name : '',
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
                items: IncomeCategories.list
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
              incomesBloc.dispatch(UpdateIncome(Income(_name,
                  id: income.id, amount: _amount, category: _category)));
            } else {
              incomesBloc.dispatch(AddIncome(
                  Income(_name, amount: _amount, category: _category)));
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
