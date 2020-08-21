import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:morestate/model/model.dart';
import 'package:morestate/model/uistate.dart';
import 'package:morestate/backend.dart';
import 'package:morestate/ui/schemalistwidget.dart';
import 'package:morestate/ui/scenelistwidget.dart';

// https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
//
// And now with provider:
// https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple

void main() {
  // create the backend object
  LocalModelStorage backend = LocalModelStorage();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => Model.connectBackend(backend)),
      ChangeNotifierProvider(create: (context) => UIState()),
    ],
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

class MyHomePage extends StatelessWidget {
  void _updateModel(BuildContext context) {
    Model m = Provider.of<Model>(context, listen: false);
    UIState uistate = Provider.of<UIState>(context, listen: false);
    if (0 == uistate.page) {
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
                Provider.of<UIState>(context, listen: false).page = 0;
              },
            ),
            ListTile(
              title: Consumer<Model>(builder: (context, value, child) {
                return Text("Scene count: ${value.getSceneCount()}");
              }),
              onTap: () {
                Navigator.pop(context);
                Provider.of<UIState>(context, listen: false).page = 1;
              },
            ),
          ],
        ),
      ),
      body: Consumer<UIState>(builder: (context, value, child) {
        return 0 == value.page ? SchemaListWidget() : SceneListWidget();
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _updateModel(context);
        },
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
