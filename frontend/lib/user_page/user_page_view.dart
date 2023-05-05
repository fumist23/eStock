import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui_components/appbar.dart';

class UserPageView extends StatelessWidget {
  const UserPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarComponent(
        title: "マイページ",
        useLeading: false,
        useActions: false,
      ),
      body: Center(
        child: Text("user"),
      ),
    );
  }
}
