import 'package:flutter/material.dart';

void showNetworkSnackBar(BuildContext context, {required bool isConnected, required VoidCallback onRetry}) {
  ScaffoldMessenger.of(context).clearSnackBars();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            isConnected ? Icons.wifi : Icons.wifi_off,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isConnected ? 'Connected to the Internet' : 'No Internet Connection',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          if (!isConnected)
            TextButton(
              onPressed: onRetry,
              child: const Text(
                "Retry",
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      backgroundColor: isConnected ? Colors.green : Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      elevation: 6.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      duration: isConnected ? const Duration(seconds: 3) : const Duration(days: 365),
    ),
  );
}
