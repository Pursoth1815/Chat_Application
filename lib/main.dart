import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:neighborgood/core/constants/app_constants.dart';
import 'package:neighborgood/core/services/network_services/network_listiner.dart';
import 'package:neighborgood/features/create_post/presentation/pages/create_post_screen.dart';
import 'package:neighborgood/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(const ProviderScope(child: MainApp()));
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConstants.init(context);

    return MaterialApp(
      home: Scaffold(
        body: NetworkListener(child: CreatePostScreen()),
      ),
    );
  }
}
