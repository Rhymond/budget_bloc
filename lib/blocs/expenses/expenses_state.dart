import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class ExpensesState extends Equatable {
  ExpensesState([List props = const []]) : super(props);
}

class ExpensesLoading extends ExpensesState {
  @override
  String toString() => 'ExpensesLoading';
}

class ExpensesLoaded extends ExpensesState {
  final List<Expense> expenses;

  ExpensesLoaded([this.expenses = const[]]) : super([expenses]);

  @override
  String toString() => 'ExpensesLoaded { expenses: $expenses }';
}

class ExpensesNotLoaded extends ExpensesState {
  @override
  String toString() => 'ExpensesNotLoaded';
}
