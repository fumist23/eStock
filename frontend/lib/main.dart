import 'package:flutter/material.dart';
import 'package:flutter_application_2/component/bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eStock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButtomNavigationBar(),
    );
  }
}
