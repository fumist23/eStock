import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/auth/auth_view_model.dart';
import 'package:flutter_application_2/app/component/appbar_design.dart';
import 'package:flutter_application_2/app/component/bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';
  Future<void> _onPressed() async {
    await ref
        .watch(authViewModelProvider)
        .signInWithEmailAndPassword(email: email, password: password);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const BottomNavigation())),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Login',
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'パスワード'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                // メッセージ表示
                child: Text(infoText),
              ),
              SizedBox(
                width: double.infinity,
                // ユーザー登録ボタン
                child: ElevatedButton(
                  child: const Text('ログイン'),
                  onPressed: _onPressed,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
