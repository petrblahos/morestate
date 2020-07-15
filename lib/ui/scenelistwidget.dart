import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';
import 'package:morestate/ui/modelwidget.dart';

class SceneListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> ret = List<Widget>();
    for (Scene i in ModelWidget.of(context).model.scenes) {
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
