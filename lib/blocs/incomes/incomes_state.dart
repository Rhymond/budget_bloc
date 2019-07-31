import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class IncomesState extends Equatable {
  IncomesState([List props = const []]) : super(props);
}

class IncomesLoading extends IncomesState {
  @override
  String toString() => 'IncomesLoading';
}

class IncomesLoaded extends IncomesState {
  final List<Income> incomes;

  IncomesLoaded([this.incomes = const[]]) : super([incomes]);

  @override
  String toString() => 'IncomesLoaded { incomes: $incomes }';
}

class IncomesNotLoaded extends IncomesState {
  @override
  String toString() => 'IncomesNotLoaded';
}
