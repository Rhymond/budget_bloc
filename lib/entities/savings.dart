// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

class SavingsEntity {
  final int percentage;

  SavingsEntity(this.percentage);

  @override
  int get hashCode => percentage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingsEntity &&
          runtimeType == other.runtimeType &&
          percentage == other.percentage;

  Map<String, Object> toJson() {
    return {
      "percentage": percentage,
    };
  }

  @override
  String toString() {
    return 'SavingsEntity {percentage: $percentage}';
  }

  static SavingsEntity fromJson(Map<String, Object> json) {
    return SavingsEntity(
      json["percentage"] as int,
    );
  }
}
