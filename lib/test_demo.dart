import 'package:flutter/material.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          const Text('41'),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonColumn(color, Icons.call, 'CALL'),
        _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
        _buildButtonColumn(color, Icons.share, 'SHARE'),
      ],
    );

    Widget textSection = const Padding(
      padding: EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
        'Alps. Situated 1,578 meters above sea level, it is one of the '
        'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
        'half-hour walk through pastures and pine forest, leads you to the '
        'lake, which warms to 20 degrees Celsius in the summer. Activities '
        'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListView(
          children: [
            Image.asset(
              'assets/images/111.png',
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        onTap: () {
          onCartChanged(product, inCart);
        },
        leading: CircleAvatar(
          backgroundColor: _getColor(context),
          child: Text(product.name[0]),
        ),
        title: Text(product.name, style: _getTextStyle(context)),
      ),
    );
  }
}

/*
 * Created by 李卓原 on 2018/9/7.
 * email: zhuoyuan93@gmail.com
 *
 */

/*
class TextFieldAndCheckPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TextFieldAndCheckPageState();
}

class TextFieldAndCheckPageState extends State<TextFieldAndCheckPage> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  TextEditingController _textController = TextEditingController();

  String value;

  FocusNode secondTextFieldNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      print(_textController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('输入和选择'),
      ),
      body: ListView(
        children: <Widget>[
          TextField(
            */
/* onChanged: (text) {
          value = text;
          print(value);
        },*/ /*

            autofocus: false, //是否自动获取焦点
            controller: _textController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.chevron_right),
              //输入框内右侧图标
              icon: Icon(Icons.person),
              //输入框左侧图标
              prefixIcon: Icon(Icons.skip_previous),
              //输入框内左侧图标
              labelText: 'labelText',
              hintText: 'hintText',
              helperText: 'helperText',
            ),
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(secondTextFieldNode),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.black12,
              constraints: BoxConstraints(maxHeight: 30),
              child: TextField(
                textAlignVertical: TextAlignVertical.bottom,
                focusNode: secondTextFieldNode,
                decoration: InputDecoration(
                  //    contentPadding: EdgeInsets.all(0),
                  hintText: '请输入',
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                textCapitalization: TextCapitalization.characters,
              ),
            ),
          ),
          _form()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print),
        onPressed: () {
          //print(value);
        },
      ),
    );
  }

  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('手机号码格式不对'),
          ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('请填写密码'),
          ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('登录成功'),
          ));
      onTextClear();
    }
  }

  void onTextClear() {
    setState(() {
      phoneController.clear();
      passController.clear();
    });
  }

  ///验证码组件
  verificationCode() {
    var textSize = 50.0;
    var spaceWidth = 30.0;
    var letterSpacing = 30.0;
    var underLineBorder = DottedLineUnderlineInputBorder(
      spaceWidth: spaceWidth,
      textSize: textSize,
      textLength: 4,
      letterSpacing: letterSpacing,
      borderSide: BorderSide(color: Colors.black26, width: 2.0),
    );
    return TextField(
      maxLength: 4,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: textSize,
        color: Colors.black87,
        letterSpacing: letterSpacing,
      ),
      decoration: InputDecoration(
        hintText: '    请 输 入 验 证 码',
        hintStyle: TextStyle(fontSize: 14.0, letterSpacing: 0.0),
        enabledBorder: underLineBorder,
        focusedBorder: underLineBorder,
      ),
    );
  }

  Widget _form() {
    return (Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.phone),
              labelText: '请输入你的用户名)',
              helperText: '请输入注册的手机号',
            ),
            autofocus: false,
          ),
          TextField(
              controller: passController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入密码)',
              ),
              obscureText: true),
          verificationCode(),
          RaisedButton(
            onPressed: _login,
            child: Text('登录'),
          ),
        ],
      ),
    ));
  }
}
*/
