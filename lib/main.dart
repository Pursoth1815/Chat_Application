import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/services/network_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final networkState = ref.watch(networkProvider);
    final notifier = ref.read(networkProvider.notifier);

    useEffect(() {
      if (!networkState.isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No Internet Connection'),
            action: SnackBarAction(
              label: "Retry",
              onPressed: () => notifier.refreshConnection(),
            ),
          ),
        );
      }
      return null;
    }, [networkState.isConnected]);

    return MaterialApp(
      home: Scaffold(
        body: IgnorePointer(
          ignoring: !networkState.isConnected,
          child: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
