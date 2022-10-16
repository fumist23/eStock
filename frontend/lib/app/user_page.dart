import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/auth/auth_view_model.dart';
import 'package:flutter_application_2/app/top_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('ログアウトしますか？'),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: const Text('はい'),
                        onPressed: () {
                          ref.watch(authViewModelProvider).signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TopPage(),
                              ),
                              (_) => false);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('いいえ'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(
          "UserPage",
          style: GoogleFonts.pacifico(
            fontSize: 17.0,
            color: Colors.black,
          ),
        ),
      ),
      body: const Center(
        child: Text("UserPage"),
      ),
    );
  }
}
