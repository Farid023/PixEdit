import 'package:flutter/material.dart';

SnackBar customSnackBar(
    {required BuildContext context,
    required String message,
    required String label,
    required void Function() onActionPressed}) {
  return SnackBar(
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 8),
    content: Text(message),
    action: SnackBarAction(
      label: label,
      onPressed: onActionPressed,
    ),
  );
}
