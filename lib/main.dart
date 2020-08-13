import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:morestate/model/model.dart';
import 'package:morestate/backend.dart';
import 'package:morestate/ui/modelwidget.dart';
import 'package:morestate/ui/schemalistwidget.dart';
import 'package:morestate/ui/scenelistwidget.dart';

// https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
//
// And now with provider:
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => Model(),
    child: MyApp(),
  ));
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
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;

  void _updateModel() {
    Model m = Provider.of<Model>(context, listen: false);
    if (0 == _page) {
      m.addSchema();
    } else {
      m.addScene();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<Model>(builder: (context, value, child) {
          return AppBarText();
        }),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("HEADER")),
            ListTile(
              title: Consumer<Model>(builder: (context, value, child) {
                return Text("Schema count: ${value.getSchemaCount()}");
              }),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _page = 0;
                });
              },
            ),
            ListTile(
              title: Consumer<Model>(builder: (context, value, child) {
                return Text("Scene count: ${value.getSceneCount()}");
              }),
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
      body: 0 == _page ? SchemaListWidget() : SceneListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateModel,
        tooltip: 'Add an item',
        child: Icon(Icons.add),
      ),
    );
  }
}

class AppBarText extends StatelessWidget {
  Widget build(BuildContext context) {
    Model m = Provider.of<Model>(context, listen: false);
    String t;
    t = "Schemas: ${m.schemas.length}, Scenes: ${m.scenes.length}";
    return Text(t);
  }
}
