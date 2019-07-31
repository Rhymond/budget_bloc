import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class IncomesEvent extends Equatable {
  IncomesEvent([List props = const []]) : super(props);
}

class LoadIncomes extends IncomesEvent {
  @override
  String toString() => 'LoadIncomes';
}

class AddIncome extends IncomesEvent {
  final Income income;

  AddIncome(this.income) : super([income]);

  @override
  String toString() => 'AddIncome { income: $income }';
}

class UpdateIncome extends IncomesEvent {
  final Income income;

  UpdateIncome(this.income) : super([income]);

  @override
  String toString() => 'UpdateIncome { income: $income }';
}

class DeleteIncome extends IncomesEvent {
  final Income income;

  DeleteIncome(this.income) : super([income]);

  @override
  String toString() => 'DeleteIncome { income: $income }';
}