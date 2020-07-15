import 'package:flutter/material.dart';

import 'package:morestate/model/model.dart';

class ModelWidget extends InheritedWidget {
  final Model model;
  final int page;
  ModelWidget({Widget child, @required this.model, @required this.page})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ModelWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ModelWidget>();
}
