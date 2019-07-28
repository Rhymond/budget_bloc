import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class ExpensesEvent extends Equatable {
  ExpensesEvent([List props = const []]) : super(props);
}

class LoadExpenses extends ExpensesEvent {
  @override
  String toString() => 'LoadExpenses';
}

class AddExpense extends ExpensesEvent {
  final Expense expense;

  AddExpense(this.expense) : super([expense]);

  @override
  String toString() => 'AddExpense { expense: $expense }';
}

class UpdateExpense extends ExpensesEvent {
  final Expense expense;

  UpdateExpense(this.expense) : super([expense]);

  @override
  String toString() => 'UpdateExpense { expense: $expense }';
}

class DeleteExpense extends ExpensesEvent {
  final Expense expense;

  DeleteExpense(this.expense) : super([expense]);

  @override
  String toString() => 'DeleteExpense { expense: $expense }';
}