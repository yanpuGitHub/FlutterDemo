import 'package:flutter/material.dart';

/// 登录
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text(
            "密码登录",
            style: TextStyle(
                inherit: false,
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
