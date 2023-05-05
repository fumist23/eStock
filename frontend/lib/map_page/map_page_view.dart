import 'package:flutter/material.dart';
import 'package:flutter_application_2/ui_components/appbar.dart';

class MapPageView extends StatelessWidget {
  const MapPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarComponent(
        title: "マップ",
        useLeading: false,
        useActions: false,
      ),
      body: Center(
        child: Text("map"),
      ),
    );
  }
}
