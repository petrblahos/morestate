// Manual serialization as described here:
// https://flutter.dev/docs/development/data-and-backend/json

// Using provider for simple state management:
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple
// Have to turn our model into ChangeNotifier

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:morestate/backend.dart';

class Schema {
  final String name;
  final String info;
  Schema(this.name, this.info);

  Schema.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        info = json['info'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'info': info,
      };
}

class Scene {
  final String name;
  Scene(this.name);

  Scene.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

class Model extends ChangeNotifier {
  List<Schema> _schemas = List<Schema>();
  List<Scene> _scenes = List<Scene>();

  Model();

  UnmodifiableListView<Schema> get schemas =>
      UnmodifiableListView<Schema>(_schemas);
  UnmodifiableListView<Scene> get scenes =>
      UnmodifiableListView<Scene>(_scenes);

  int getSchemaCount() => _schemas.length;
  int getSceneCount() => _scenes.length;

  void addScene() {
    _scenes.add(Scene("New scene"));
    notifyListeners();
  }

  void insertScene(int index, Scene element) {
    _scenes.insert(index, element);
    notifyListeners();
  }

  void insertSchema(int index, Schema element) {
    _schemas.insert(index, element);
    notifyListeners();
  }

  void addSchema() {
    _schemas.add(Schema("New schema", "Description"));
    notifyListeners();
  }

  void deleteScene(int index) {
    _scenes.removeAt(index);
    notifyListeners();
  }

  void deleteSchema(int index) {
    _schemas.removeAt(index);
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {
        'schemas': _schemas,
        'scenes': _scenes,
      };

  Model.connectBackend(LocalModelStorage backend) {
    loadFromBackend(backend);
  }

  void loadFromBackend(LocalModelStorage backend) async {
    Map<String, dynamic> json = await backend.loadJson();
    for (var i in json["schemas"]) {
      _schemas.add(Schema.fromJson(i));
    }
    for (var i in json["scenes"]) {
      _scenes.add(Scene.fromJson(i));
    }
    notifyListeners();
    addListener(() {
      backend.storeModel(this);
    });
  }
}
