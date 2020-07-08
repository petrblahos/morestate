import 'package:flutter/material.dart';

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Model _model = Model();
  int _page = 0;

  void _updateModel() {
    setState(() {
      if (0 == _page) {
        _model.schemas.add(Schema("new-schema", "schema-info"));
      } else {
        _model.scenes.add(Scene("new-scena"));
      }
    });
  }

  List<Widget> _buildContents() {
    List<Widget> ret = List<Widget>();
    if (0 == _page) {
      for (Schema i in _model.schemas) {
        ret.add(Text("${i.name} :: ${i.info}"));
      }
    } else {
      for (Scene i in _model.scenes) {
        ret.add(Text("scene ${i.name}"));
      }
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Count: ${0 == _page ? _model.schemas.length : _model.scenes.length}"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("HEADER")),
            ListTile(
              title: Text("Schema count: ${_model.schemas.length}"),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _page = 0;
                });
              },
            ),
            ListTile(
              title: Text("Scene count: ${_model.scenes.length}"),
              onTap: () {
                setState(() {
                  _page = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildContents(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateModel,
        tooltip: 'Add an item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
