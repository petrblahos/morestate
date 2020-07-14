import 'package:flutter/material.dart';
import 'package:morestate/model/model.dart';

class SceneListWidget extends StatefulWidget {
  final Model _model;
  SceneListWidget(this._model, {Key key}) : super(key: key);

  @override
  _SceneListState createState() => _SceneListState();
}

class _SceneListState extends State<SceneListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> ret = List<Widget>();
    for (Scene i in widget._model.scenes) {
      ret.add(ListTile(
        title: Text("${i.name}"),
        subtitle: Text("Scene..."),
      ));
    }
    return ListView(
      children: ret,
    );
  }
}
