import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/app/auth/auth_view_model.dart';
import 'package:flutter_application_2/app/component/appbar_design.dart';
import 'package:flutter_application_2/app/component/bottom_navigation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  String infoText = '';
  String email = '';
  String password = '';

  Future<void> _onPressed() async {
    ref.watch(authViewModelProvider).createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: ((context) => const BottomNavigation())),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        title: 'Signin',
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
                decoration: const InputDecoration(labelText: 'パスワード(6文字以上)'),
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(infoText),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('ユーザー登録'),
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
