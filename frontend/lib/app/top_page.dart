import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'auth/login_page.dart';
import 'auth/signin_page.dart';
import 'package:flutter_application_2/app/home_page.dart';

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                  child: const Text(
                    'ホーム(仮)',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        builder: (context) => const SizedBox(
                              child: LoginPage(),
                            ));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'or',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    showCupertinoModalBottomSheet(
                        context: context,
                        enableDrag: true,
                        builder: (context) => SizedBox(
                              child: SignInPage(),
                            ));
                  },
                  child: const Text(
                    'Signup',
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
