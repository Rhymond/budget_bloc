import 'package:todos_app_core/todos_app_core.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/entities/entities.dart';

@immutable
class Expense extends Equatable {
  final String id;
  final String category;
  final int amount;
  final String name;

  Expense(this.name, {String category = '', String id, int amount})
      : this.category = category ?? 'Other',
        this.id = id ?? Uuid().generateV4(),
        this.amount = amount ?? 0,
        super([category, id, name, amount]);

  Expense copyWith({String id, String name, int amount, String category}) {
    return Expense(
      name ?? this.name,
      category: category ?? this.category,
      id: id ?? this.id,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'Todo { name: $name, category: $category, amount: $amount, id: $id }';
  }

  ExpenseEntity toEntity() {
    return ExpenseEntity(name, id, amount, category);
  }

  static Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      entity.name,
      category: entity.category ?? '',
      amount: entity.amount ?? 0,
      id: entity.id ?? Uuid().generateV4(),
    );
  }
}
