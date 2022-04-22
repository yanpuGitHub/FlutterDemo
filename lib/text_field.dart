import 'package:f_demo/res/my_color.dart';
import 'package:f_demo/uitls/phone_patter.dart';
import 'package:f_demo/view/check_text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/gallery_localizations.dart';

import 'res/my_string.dart';

class LoginActivity extends StatefulWidget {
  const LoginActivity({Key? key, this.phone}) : super(key: key);

  final String? phone;

  @override
  State<StatefulWidget> createState() => _LoginActivity();
}

class _LoginActivity extends State<LoginActivity> with WidgetsBindingObserver {
  String loginWayText = MyStrings.loginPasswordText;
  String loginCodeText = "获取验证码";
  String loginPasswordText = "登录";
  bool isCodeLogin = false;

  // 手机号是否有输入
  bool hasUserContain = false;
  bool hasPasswordContain = false;
  bool isShowPassword = true;

  // 输入的内容
  String userContain = "";
  String passwordContain = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late AppLifecycleState _lastLifecycleState;

  @override
  void dispose() {
    super.dispose();
    debugPrint("dispose");
    WidgetsBinding.instance?.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint("didChangeAppLifecycleState:$state");
    setState(() {
      debugPrint("didChangeAppLifecycleState--->$state");
      _lastLifecycleState = state;
    });
  }

  @override
  void initState() {
    super.initState();
    debugPrint("initState");
    WidgetsBinding.instance?.addObserver(this);
    phoneController.text = widget.phone ?? "";
    splitPhoneNumber.splitPhoneNumber(phoneController, phoneController.text);
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

  int position = 0;

  TextField _buildUserTextField() {
    return TextField(
      controller: phoneController,
      autocorrect: false,
      autofocus: true,
      obscuringCharacter: "*",
      onChanged: (text) {
        debugPrint("输入：$text");
        // _splitPhoneNumber(text);
        setState(() {
          splitPhoneNumber.splitPhoneNumber(
              phoneController, phoneController.text);
        });
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(13),
      ],
      // maxLength: 13,
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
          // counterText: "",
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
    // GalleryLocalizations.
    GalleryLocalizations.of(context);
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ''),
        Locale('es', ''),
      ],
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(top: 30, left: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                      ),
                      child: _buildPasswordTextField(),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 44,
                        width: double.infinity,
                        margin: const EdgeInsets.only(right: 32),
                        decoration: const BoxDecoration(
                          color: MyColors.colorFfa6a6,
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        child: Center(
                          child: Text(
                            loginPasswordText,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.7,
                          alignment: Alignment.centerLeft,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            value: valueb,
                            onChanged: (value) {
                              setState(() {
                                valueb = value;
                              });
                            },
                            checkColor: Colors.white,
                            activeColor: Colors.red,
                          ),
                        ),
                        const Text(
                          "我已阅读并同意",
                          style:
                              TextStyle(color: MyColors.color99, fontSize: 12),
                        ),
                        TextButton(
                            onPressed: () {
                              debugPrint("我是用户协议啊");
                            },
                            style: TextButton.styleFrom(
                              shape: null,
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                            ),
                            child: const Text(
                              "《用户协议》",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )),
                        const Text(
                          "和",
                          style:
                              TextStyle(color: MyColors.color99, fontSize: 12),
                        ),
                        TextButton(
                          onPressed: () {
                            debugPrint("我是隐私条款啊");
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                          ),
                          child: const Text(
                            "《隐私条款》",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 30, bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "其他登录方式",
                        style: TextStyle(fontSize: 16, color: MyColors.color66),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: const [
                              Icon(
                                Icons.wallet_giftcard_rounded,
                                color: MyColors.color66,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "微信",
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.color66),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 65,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: const [
                              Icon(
                                Icons.paste_outlined,
                                color: MyColors.color66,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "密码",
                                style: TextStyle(
                                    fontSize: 16, color: MyColors.color66),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(6),
                      child: GestureDetector(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              "使用有问题？",
                              style: TextStyle(
                                  fontSize: 12, color: MyColors.color33),
                            ),
                            Text(
                              "帮助与反馈",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: MyColors.color33,
                                  decoration: TextDecoration.underline),
                            ),
                            Text(
                              ">",
                              style: TextStyle(
                                fontSize: 12,
                                color: MyColors.color33,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool? valueb = false;
}
