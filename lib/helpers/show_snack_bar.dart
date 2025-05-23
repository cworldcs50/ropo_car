import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackBar(String message) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(content: Text(message)),
    snackBarAnimationStyle: AnimationStyle(
      duration: Duration(milliseconds: 1000),
    ),
  );
}
