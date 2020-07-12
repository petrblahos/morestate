// Manual serialization as described here:
// https://flutter.dev/docs/development/data-and-backend/json

class Schema {
  String name;
  String info;
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
  String name;
  Scene(this.name);

  Scene.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };
}

class Model {
  List<Schema> schemas = List<Schema>();
  List<Scene> scenes = List<Scene>();

  Model();

  Map<String, dynamic> toJson() => {
        'schemas': schemas,
        'scenes': scenes,
      };

  Model.fromJson(Map<String, dynamic> json) {
    for (var i in json["schemas"]) {
      schemas.add(Schema.fromJson(i));
    }
    for (var i in json["scenes"]) {
      scenes.add(Scene.fromJson(i));
    }
  }
}
