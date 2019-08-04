import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class SavingsState {
  SavingsState([List props = const []]);
}

class SavingsLoading extends SavingsState {
  @override
  String toString() => 'SavingsLoading';
}

class SavingsLoaded extends SavingsState {
  final Savings savings;

  SavingsLoaded([this.savings]);

  @override
  String toString() => 'SavingsLoaded { savings: $savings }';
}

class SavingsNotLoaded extends SavingsState {
  @override
  String toString() => 'SavingsNotLoaded';
}
