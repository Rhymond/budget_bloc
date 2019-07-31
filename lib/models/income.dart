import 'package:todos_app_core/todos_app_core.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/entities/entities.dart';

@immutable
class Income extends Equatable {
  final String id;
  final String category;
  final int amount;
  final String name;

  Income(this.name, {String category, String id, int amount})
      : this.category = category ?? 'Other',
        this.id = id ?? Uuid().generateV4(),
        this.amount = amount ?? 0,
        super([category, id, name, amount]);

  Income copyWith({String id, String name, int amount, String category}) {
    return Income(
      name ?? this.name,
      category: category ?? this.category,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  IncomeEntity toEntity() {
    return IncomeEntity(name, id, amount, category);
  }

  static Income fromEntity(IncomeEntity entity) {
    return Income(
      entity.name,
      category: entity.category ?? '',
      amount: entity.amount ?? 0,
      id: entity.id ?? Uuid().generateV4(),
    );
  }

  @override
  String toString() {
    return 'Income { name: $name, category: $category, amount: $amount, id: $id }';
  }
}
