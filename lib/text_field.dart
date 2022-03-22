import 'package:f_demo/res/my_color.dart';
import 'package:f_demo/uitls/phone_patter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'res/my_string.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginActivity();
}

class _LoginActivity extends State<LoginActivity> {
  String loginWayText = MyStrings.loginPasswordText;

  // 手机号是否有输入
  bool hasUserContain = false;
  bool hasPasswordContain = false;
  bool isShowPassword = true;

  // 输入的内容
  String userContain = "";
  String passwordContain = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneController.addListener(() {
      debugPrint("手机号：${phoneController.text}");
      setState(() {
        userContain = phoneController.text;
        hasUserContain = phoneController.text.isNotEmpty;
      });
    });

    passwordController.addListener(() {
      debugPrint("密码：${passwordController.text}");
      setState(() {
        passwordContain = passwordController.text;
        hasPasswordContain = passwordController.text.isNotEmpty;
      });
    });
  }

  SplitPhoneNumber splitPhoneNumber = SplitPhoneNumber();

  OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: MyColors.color99, width: 0.5),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  TextField _buildUserTextField() {
    return TextField(
      controller: phoneController,
      onChanged: (text) {
        debugPrint("输入：$text");
        // _splitPhoneNumber(text);
        splitPhoneNumber.splitPhoneNumber(phoneController, text);
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
      ],
      cursorColor: Colors.red,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      // decoration: const InputDecoration.collapsed(hintText: "点击输入11位手机号"),
      decoration: InputDecoration(
          isCollapsed: false,
          border: InputBorder.none,
          // 显示左外侧图标
          // icon: const Icon(
          //   Icons.phone,
          //   color: Colors.red,
          // ),
          // // 显示左内侧图标
          // prefixIcon: const Icon(
          //   Icons.person,
          // ),
          suffixIcon: Visibility(
              visible: hasUserContain,
              child: IconButton(
                  onPressed: () {
                    phoneController.clear();
                  },
                  icon: const Icon(
                    Icons.close,
                    color: MyColors.color99,
                  ))),
          // 当有maxLength时，这个设置counter: Text("")可以去除右下角的计数器
          counterText: "",
          hintText: "点击输入11位手机号",
          hintStyle: const TextStyle(fontSize: 17, color: MyColors.color99)),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: passwordController,
/*      onChanged: (text) {
        debugPrint("输入：$text");

      },*/
      cursorColor: Colors.red,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isShowPassword,
      // 改变密码的样式
      obscuringCharacter: "*",
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          isCollapsed: false,
          border: InputBorder.none,
          // 显示左外侧图标
          // icon: const Icon(
          //   Icons.phone,
          //   color: Colors.red,
          // ),
          // // 显示左内侧图标
          // prefixIcon: const Icon(
          //   Icons.person,
          // ),
          suffixIcon: Visibility(
            visible: hasPasswordContain,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },
              icon: Icon(
                isShowPassword
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye_sharp,
                color: MyColors.color99,
              ),
            ),
          ),
          // 当有maxLength时，这个设置counter: Text("")可以去除右下角的计数器
          counterText: "",
          hintText: "点击输入密码",
          hintStyle: const TextStyle(fontSize: 17, color: MyColors.color99)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(top: 30, left: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loginWayText,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "未注册手机号将自动注册并登录",
                style: TextStyle(color: MyColors.color99, fontSize: 14),
              ),
              const SizedBox(
                height: 44,
              ),
              Container(
                margin: const EdgeInsets.only(right: 32),
                height: 44,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.color99, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: _buildUserTextField(),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                margin: const EdgeInsets.only(right: 32),
                height: 44,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.color99, width: 0.5),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                child: _buildPasswordTextField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
