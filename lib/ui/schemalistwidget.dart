import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';

class SchemaListWidget extends StatefulWidget {
  final Model _model;
  SchemaListWidget(this._model, {Key key}) : super(key: key) {
    print("SchemaListWidget constructor, model: ${_model.schemas.length}");
  }

  @override
  _SchemaListState createState() {
    print("SchemaListWidget createState, model: ${_model.schemas.length}");
    return _SchemaListState(_model);
  }
}

class _SchemaListState extends State<SchemaListWidget> {
  Model _model;
  _SchemaListState(this._model) {
    print("_SchemaListState constructor, model: ${_model.schemas.length}");
  }
  @override
  Widget build(BuildContext context) {
    print("_SchemaListState build, model: ${_model.schemas.length}");
    List<Widget> ret = List<Widget>();
    for (Schema i in _model.schemas) {
      ret.add(ListTile(
        title: Text(i.name),
        subtitle: Text(i.info),
      ));
    }
    return ListView(
      children: ret,
    );
  }
}
