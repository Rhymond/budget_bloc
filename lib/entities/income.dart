// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class IncomeEntity {
  final String id;
  final String category;
  final int amount;
  final String name;

  IncomeEntity(this.name, this.id, this.amount, this.category);

  @override
  int get hashCode =>
      name.hashCode ^ id.hashCode ^ amount.hashCode ^ category.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is IncomeEntity &&
              runtimeType == other.runtimeType &&
              category == other.category &&
              name == other.name &&
              amount == other.amount &&
              id == other.id;

  Map<String, Object> toJson() {
    return {
      "category": category,
      "amount": amount,
      "name": name,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'IncomeEntity {category: $category, amount: $amount, name: $name, id: $id}';
  }

  static IncomeEntity fromJson(Map<String, Object> json) {
    return IncomeEntity(
      json["name"] as String,
      json["id"] as String,
      json["amount"] as int,
      json["category"] as String,
    );
  }
}
