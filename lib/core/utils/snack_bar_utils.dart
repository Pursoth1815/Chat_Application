import 'package:flutter/material.dart';

enum SnackBarType { alert, network }

enum SnackBarStatus { success, failure, warning }

enum SnackPosition { top, bottom }

void showCustomSnackbar(
  BuildContext context, {
  required SnackBarStatus status,
  required String message,
  VoidCallback? onRetry,
  SnackBarType type = SnackBarType.alert,
  Duration duration = const Duration(seconds: 3),
  SnackPosition position = SnackPosition.bottom,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  Color backgroundColor;
  IconData icon;

  switch (type) {
    case SnackBarType.network:
      switch (status) {
        case SnackBarStatus.success:
          backgroundColor = Colors.green;
          icon = Icons.wifi;
          break;
        case SnackBarStatus.failure:
          backgroundColor = Colors.red;
          icon = Icons.wifi_off;
          break;
        default:
          backgroundColor = Colors.grey;
          icon = Icons.info;
          break;
      }
      break;

    case SnackBarType.alert:
      switch (status) {
        case SnackBarStatus.success:
          backgroundColor = Colors.green;
          icon = Icons.check_circle;
          break;
        case SnackBarStatus.failure:
          backgroundColor = Colors.red;
          icon = Icons.error;
          break;
        case SnackBarStatus.warning:
          backgroundColor = Colors.yellow;
          icon = Icons.warning;
          break;
        default:
          backgroundColor = Colors.grey;
          icon = Icons.info;
          break;
      }
      break;
  }

  final snackbar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        if (status != SnackBarStatus.success)
          TextButton(
            onPressed: onRetry,
            child: const Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
          ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    elevation: 6.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: status == SnackBarStatus.success
        ? EdgeInsets.only(
            top: MediaQuery.of(context).size.height - 150,
            left: 16,
            right: 16,
          )
        : EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
    duration: duration,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
