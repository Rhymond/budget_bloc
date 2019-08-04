import 'package:todos_app_core/todos_app_core.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/entities/entities.dart';

@immutable
class Savings extends Equatable {
  final int percentage;

  Savings(percentage)
      : this.percentage = percentage ?? 0,
        super([percentage]);

  Savings copyWith({int percentage}) {
    return Savings(
      percentage ?? this.percentage,
    );
  }

  SavingsEntity toEntity() {
    return SavingsEntity(percentage);
  }

  static Savings fromEntity(SavingsEntity entity) {
    return Savings(
      entity.percentage,
    );
  }

  @override
  String toString() {
    return 'Savings { percentage: $percentage }';
  }
}
