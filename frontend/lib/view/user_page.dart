import 'package:flutter/material.dart';
import 'package:flutter_application_2/component/appbar_design.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'UserPage',
      ),
      body: const Center(
        child: Text('UserPagge'),
      ),
    );
  }
}
