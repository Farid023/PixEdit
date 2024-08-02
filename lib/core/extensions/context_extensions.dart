import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  //For Display size
  double get fullHeight => MediaQuery.of(this).size.height;
  double get fullWidth => MediaQuery.of(this).size.width;


  //For Navigation
  MaterialPageRoute _materialPageRoute(page) =>
      MaterialPageRoute(builder: (_) => page);

  void replace(Widget page) =>
      Navigator.pushReplacement(this, _materialPageRoute(page));

  void to(Widget page) => Navigator.push(this, _materialPageRoute(page));

  void removeAll(Widget page) => Navigator.pushAndRemoveUntil(
      this, _materialPageRoute(page), (route) => false);

  void back() => Navigator.pop(this);

  void clearStackAndPush(Widget page) {
    Navigator.of(this).popUntil((route) => route.isFirst);
    Navigator.push(this, _materialPageRoute(page));
  }
}
