import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';
import 'package:morestate/ui/modelwidget.dart';

class SchemaListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> ret = List<Widget>();
    for (Schema i in ModelWidget.of(context).model.schemas) {
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
