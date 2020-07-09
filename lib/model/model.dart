class Schema {
  String name;
  String info;
  Schema(this.name, this.info);
}

class Scene {
  String name;
  Scene(this.name);
}

class Model {
  List<Schema> schemas = List<Schema>();
  List<Scene> scenes = List<Scene>();
}
