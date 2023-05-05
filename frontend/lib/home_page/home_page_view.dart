import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui_components/appbar.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarComponent(
        title: 'ホーム',
        useLeading: false,
        useActions: true,
      ),
      body: Center(
        child: Text("home"),
      ),
    );
  }
}
