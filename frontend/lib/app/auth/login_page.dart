import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/component/appbar_design.dart';
import 'package:flutter_application_2/app/component/bottom_navigation.dart';
import 'package:flutter_application_2/app/custom_exception.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String infoText = '';
  String email = '';
  String password = '';

//todo riverpodを使ってviewmodelへの切り分け
  Future<void> _onPressed() async {
    try {
      // メール/パスワードでログイン
      final FirebaseAuth auth = FirebaseAuth.instance;
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = result.user!;
      setState(() {
        infoText = "ログインOK：${user.email}";
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: ((context) => const BottomNavigation())),
          ((_) => false));
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
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
              // メールアドレス入力
              TextFormField(
                decoration: const InputDecoration(labelText: 'メールアドレス'),
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              // パスワード入力
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
