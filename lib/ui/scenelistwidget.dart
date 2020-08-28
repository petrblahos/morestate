import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:morestate/model/model.dart';

class SceneListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, value, child) {
      return ListView.builder(
          itemCount: value.getSceneCount(),
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key(value.scenes[index].hashCode.toString()),
              child: ListTile(
                title: Text(value.scenes[index].name),
                subtitle: Text("Scene: $index"),
              ),
              onDismissed: (direction) {
                Scaffold.of(context).removeCurrentSnackBar();
                bool undoValid = true;
                Scene deletedScene = value.scenes[index];
                value.deleteScene(index);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Row(
                  children: [
                    Expanded(child: Text("Scene $index dismissed")),
                    GestureDetector(
                      child: Text("UNDO"),
                      onTap: () {
                        if (undoValid) {
                          undoValid = false;
                          value.insertScene(index, deletedScene);
                          Scaffold.of(context).removeCurrentSnackBar();
                        }
                      },
                    ),
                  ],
                )));
              },
            );
          });
    });
  }
}
