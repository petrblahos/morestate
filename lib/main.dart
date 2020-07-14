import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';
import 'package:morestate/backend.dart';
import 'package:morestate/ui/schemalistwidget.dart';
import 'package:morestate/ui/scenelistwidget.dart';

void main() {
  runApp(MyApp(storage: LocalModelStorage()));
}

class MyApp extends StatelessWidget {
  final LocalModelStorage storage;
  MyApp({Key key, @required this.storage});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(storage: storage),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final LocalModelStorage storage;
  MyHomePage({Key key, @required this.storage}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Model _model = Model();
  int _page = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.loadModel().then((Model m) {
      setState(() {
        _model.scenes = m.scenes;
        _model.schemas = m.schemas;
        print("_MyHomePageState model loaded ${_model.schemas.length}");
      });
    });
  }

  void _updateModel() {
    setState(() {
      if (0 == _page) {
        _model.schemas.add(Schema("new-scheme", "scheme-info"));
      } else {
        _model.scenes.add(Scene("new-scene"));
      }
    });
    widget.storage.storeModel(_model).then((void v) {
      print("model stored");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_MyHomePageState build, ${_model.schemas.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Count: ${0 == _page ? _model.schemas.length : _model.scenes.length}"),
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
      body: 0 == _page ? SchemaListWidget(_model) : SceneListWidget(_model),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateModel,
        tooltip: 'Add an item',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
