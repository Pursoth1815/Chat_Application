import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homePageControllerProvider = Provider<PageController>((ref) {
  return PageController();
});

final bottomNavigationIndexProvider = StateProvider<int>((ref) {
  return 0;
});
