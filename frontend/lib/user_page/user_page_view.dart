import 'package:flutter/material.dart';

class UserPageView extends StatelessWidget {
  const UserPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("user"),
      ),
    );
  }
}
