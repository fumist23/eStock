import 'package:flutter/material.dart';
import 'package:flutter_application_2/view/login_page.dart';
import 'package:google_fonts/google_fonts.dart';

class TopPage extends StatelessWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/top_background_image.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Expanded(flex: 3, child: Container()),
                Text(
                  'eStock',
                  style: GoogleFonts.pacifico(
                    fontSize: 40.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                Expanded(flex: 4, child: Container()),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        isScrollControlled: true,
                        builder: (context) => SizedBox(
                              height: MediaQuery.of(context).size.height * 0.95,
                              child: const LoginPage(),
                            ));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
