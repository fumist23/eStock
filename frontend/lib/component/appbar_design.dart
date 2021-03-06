import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarDesign extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool useBackButton;

  AppBarDesign({required this.title, this.useBackButton = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      elevation: 0.0,
      centerTitle: true,
      leading: useBackButton
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            )
          : null,
      title: Text(
        title,
        style: GoogleFonts.pacifico(
          fontSize: 17.0,
          color: Colors.black,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
}
