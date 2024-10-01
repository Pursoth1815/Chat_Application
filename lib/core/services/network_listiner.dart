import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/services/network_service.dart';
import 'package:neighborgood/core/utils/snack_bar_utils.dart';

class NetworkListener extends HookConsumerWidget {
  final Widget child;

  const NetworkListener({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkState = ref.watch(networkProvider);
    final notifier = ref.read(networkProvider.notifier);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (_) {
        notifier.refreshConnection();
      });
      return timer.cancel;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showNetworkSnackBar(
          context,
          isConnected: networkState.isConnected,
          onRetry: () => notifier.refreshConnection(),
        );
      });
      return null;
    }, [networkState.isConnected]);

    return IgnorePointer(
      ignoring: !networkState.isConnected,
      child: child,
    );
  }
}
