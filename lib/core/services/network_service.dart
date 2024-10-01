// lib/features/auth/data/network_provider.dart

import 'dart:io';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NetworkState {
  final bool isConnected;
  NetworkState(this.isConnected);
}

class NetworkNotifier extends StateNotifier<NetworkState> {
  NetworkNotifier() : super(NetworkState(true));

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> refreshConnection() async {
    final isConnected = await checkInternetConnection();
    state = NetworkState(isConnected);
  }
}

final networkProvider = StateNotifierProvider<NetworkNotifier, NetworkState>((ref) {
  return NetworkNotifier();
});
