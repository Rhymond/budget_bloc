import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/models/models.dart';

@immutable
abstract class SavingsEvent extends Equatable {
  SavingsEvent([List props = const []]) : super(props);
}

class LoadSavings extends SavingsEvent {
  @override
  String toString() => 'LoadSavings';
}

class UpdateSaving extends SavingsEvent {
  final Savings saving;

  UpdateSaving(this.saving) : super([saving]);

  @override
  String toString() => 'UpdateSaving { saving: $saving }';
}