import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:morestate/model/model.dart';

class SchemaListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, value, child) {
      return ListView.builder(
        itemCount: value.getSchemaCount(),
        itemBuilder: (context, index) {
          return Dismissible(
              key: Key(value.schemas[index].hashCode.toString()),
              onDismissed: (direction) {
                Scaffold.of(context).removeCurrentSnackBar();
                bool undoValid = true;
                Schema deletedSchema = value.schemas[index];
                value.deleteSchema(index);
                Scaffold.of(context).showSnackBar(SnackBar(
                    content: Row(children: [
                  Expanded(child: Text("Schema $index dismissed")),
                  GestureDetector(
                    child: Text("UNDO"),
                    onTap: () {
                      if (undoValid) {
                        undoValid = false;
                        value.insertSchema(index, deletedSchema);
                        Scaffold.of(context).removeCurrentSnackBar();
                      }
                    },
                  ),
                ])));
              },
              child: ListTile(
                title: Text(value.schemas[index].name),
                subtitle: Text("$index: ${value.schemas[index].info}"),
              ));
        },
      );
    });
  }
}
