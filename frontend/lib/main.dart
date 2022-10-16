import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/auth/auth_view_model.dart';
import 'package:flutter_application_2/app/component/bottom_navigation.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app/top_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eStock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ref.watch(authViewModelProvider).islogedIn() == false
          ? const TopPage()
          : const BottomNavigation(),
    );
  }
}
