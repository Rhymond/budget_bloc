import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:todo/entities/entities.dart';

class ExpensesRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const ExpensesRepository(
      this.tag,
      this.getDirectory,
  );

  Future<List<ExpenseEntity>> loadExpenses() async {
    final file = await _getLocalFile();
    final expensesJSON = await file.readAsString();
    final expensesDecoded = json.decode(expensesJSON);
    if (!expensesDecoded.containsKey('expenses')) {
      return [];
    }

    final expenses = (expensesDecoded['expenses'])
        .map<ExpenseEntity>((expense) => ExpenseEntity.fromJson(expense))
        .toList();

    return expenses;
  }

  Future<File> saveExpenses(List<ExpenseEntity> expenses) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'expenses': expenses.map((expense) => expense.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();
    final file = File('${dir.path}/Storage$tag.json');
    if (!file.existsSync()) {
      file.writeAsString('{}');
    }

    return File('${dir.path}/Storage$tag.json');
  }

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }
}