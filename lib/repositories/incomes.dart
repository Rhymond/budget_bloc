import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:todo/entities/entities.dart';

class IncomesRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const IncomesRepository(
      this.tag,
      this.getDirectory,
  );

  Future<List<IncomeEntity>> loadIncomes() async {
    final file = await _getLocalFile();
    final incomesJSON = await file.readAsString();
    final incomesDecoded = json.decode(incomesJSON);
    if (!incomesDecoded.containsKey('incomes')) {
      return [];
    }

    final incomes = (incomesDecoded['incomes'])
        .map<IncomeEntity>((income) => IncomeEntity.fromJson(income))
        .toList();

    return incomes;
  }

  Future<File> saveIncomes(List<IncomeEntity> incomes) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'incomes': incomes.map((income) => income.toJson()).toList(),
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