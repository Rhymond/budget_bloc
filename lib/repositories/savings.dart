import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:todo/entities/entities.dart';

class SavingsRepository {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const SavingsRepository(
      this.tag,
      this.getDirectory,
  );

  Future<SavingsEntity> loadSavings() async {
    final file = await _getLocalFile();
    final savingsJSON = await file.readAsString();
    final savingsDecoded = json.decode(savingsJSON);
    if (!savingsDecoded.containsKey('savings')) {
      return SavingsEntity(0);
    }

    return SavingsEntity.fromJson(savingsDecoded['savings']);
  }

  Future<File> saveSavings(SavingsEntity savings) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'savings': savings.toJson(),
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