import 'package:flutter/material.dart';
import 'package:flutter_application_2/post_page.dart';

import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const PostPage()),
                  ));
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(
          'Home',
          style: GoogleFonts.pacifico(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
