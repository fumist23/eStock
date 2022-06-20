import 'package:flutter/material.dart';
import 'package:flutter_application_2/component/appbar_design.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Home',
      ),
      body: const Center(
        child: Text('home'),
      ),
    );
  }
}
