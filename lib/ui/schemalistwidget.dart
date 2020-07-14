import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';

class SchemaListWidget extends StatefulWidget {
  final Model _model;
  SchemaListWidget(this._model, {Key key}) : super(key: key);

  @override
  _SchemaListState createState() => _SchemaListState();
}

class _SchemaListState extends State<SchemaListWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> ret = List<Widget>();
    for (Schema i in widget._model.schemas) {
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
