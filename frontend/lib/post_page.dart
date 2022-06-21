import 'package:flutter/material.dart';
import 'package:flutter_application_2/component/appbar_design.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Post',
        useBackButton: true,
      ),
      body: const Center(
        child: Text('PostPage'),
      ),
    );
  }
}
