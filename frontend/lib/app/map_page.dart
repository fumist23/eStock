import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/component/appbar_design.dart';


class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Map',
      ),
      body: const Center(
        child: Text('map'),
      ),
    );
  }
}
