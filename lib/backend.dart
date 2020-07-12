import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:morestate/model/model.dart';

// https://flutter.dev/docs/cookbook/persistence/reading-writing-files

class LocalModelStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/modelstorage.txt');
  }

  Future<Model> loadModel() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return Model.fromJson(jsonDecode(contents));
    } catch (e) {
      // If encountering an error, return an empty model
      return Model();
    }
  }

  Future<void> storeModel(Model model) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(model));
  }
}
