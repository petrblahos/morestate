import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:morestate/model/model.dart';

class SceneListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, value, child) {
      List<Widget> ret = List<Widget>();
      for (var i in value.scenes) {
        ret.add(ListTile(
          title: Text(i.name),
          subtitle: Text("Scene..."),
        ));
      }
      return ListView(children: ret);
    });
  }
}
