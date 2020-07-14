import 'package:flutter/material.dart';
import 'package:morestate/model/model.dart';

class SceneListWidget extends StatefulWidget {
  final Model _model;
  SceneListWidget(this._model, {Key key}) : super(key: key);

  @override
  _SceneListState createState() => _SceneListState(_model);
}

class _SceneListState extends State<SceneListWidget> {
  Model _model;
  _SceneListState(this._model);
  @override
  Widget build(BuildContext context) {
    print("_SceneListState build ${_model.scenes.length} $_model");
    List<Widget> ret = List<Widget>();
    for (Scene i in _model.scenes) {
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