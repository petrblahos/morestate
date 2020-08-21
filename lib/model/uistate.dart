import 'package:flutter/material.dart';

class UIState extends ChangeNotifier {
  int _page = 0;

  int get page => _page;
  set page(int s) {
    _page = s;
    notifyListeners();
  }

  UIState();
}
