import 'dart:math' as Math;
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CheckTextBox extends StatefulWidget {
  // 是否是check状态
  final bool isChecked;

  // check文本
  final String text;

  // check回传
  final ValueChanged<bool> onChecked;

  const CheckTextBox(
      {Key? key,
      required this.text,
      this.isChecked = false,
      required this.onChecked})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CheckTextBox();
}

class _CheckTextBox extends State<CheckTextBox> {
  // 是否是check状态
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CheckRender(isChecked: isChecked, text: widget.text),
      onTap: () => setState(() {
        isChecked = !isChecked;
        // 回传改变事件
        widget.onChecked(isChecked);
      }),
    );
  }
}

class CheckRender extends LeafRenderObjectWidget {
  final bool isChecked;
  final String text;

  const CheckRender({Key? key, required this.text, required this.isChecked})
      : super(key: key);

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _CheckedRender(checked: isChecked, text: text);

  @override
  void updateRenderObject(BuildContext context, _CheckedRender renderObject) {
    renderObject.isChecked = isChecked;
    renderObject.text = text;
  }
}

class _CheckedRender extends RenderBox {
  final _paint = Paint();
  ui.Paragraph _paragraph =
      ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: 14)).build();
  bool _checked = false;
  String _text = "";

  _CheckedRender({checked = false, text}) {
    _checked = checked;
    _text = text;
    _paint.color = const Color(0xffffffff); //白色笔
    _paint.isAntiAlias = true; // 抗锯齿
    resetText();
  }

  @override
  void performLayout() {
    double width = Math.max(constraints.minWidth, 14.0);
    double height = Math.max(constraints.minHeight, 14.0);
    width += _paragraph.minIntrinsicWidth + 5.5;
    // 最终宽度
    size = Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    Canvas canvas = context.canvas;

    double _center = size.height / 2; //中心点
    double _radius = _center - _center * 0.12 / 2; //半径
    _paint.style = PaintingStyle.stroke; // 设置空心笔
    _paint.strokeWidth = size.height * 0.12; // 设置空心圆的宽度

    Offset centerH = Offset(offset.dx + _center, offset.dy + _center); //中心位置
    Rect arcRect = Rect.fromCircle(center: centerH, radius: _radius); //范围大小
    canvas.drawArc(arcRect, 0.0, 360, false, _paint); //画出空心圆

    // 判断是否选中
    if (_checked) {
      // 设置实心圆
      _paint.style = PaintingStyle.fill;
      // 画中间的圆圈
      Rect arcRectCenter =
          Rect.fromCircle(center: centerH, radius: _radius / 1.8);
      canvas.drawArc(arcRectCenter, 0.0, 360, false, _paint);
    }

    canvas.drawParagraph(
        _paragraph,
        Offset(centerH.dx + _center + 5.5,
            offset.dy + (size.height - _paragraph.height) / 2));
  }

  @override
  bool hitTest(HitTestResult result, {required ui.Offset position}) {
    if (size.contains(position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }

  @override
  bool hitTestSelf(Offset position) => true;

  void resetText() {
    var paragraph = ui.ParagraphBuilder(ui.ParagraphStyle(fontSize: 14))
      ..pushStyle(ui.TextStyle(color: const Color(0xffffffff)))
      ..addText(_text);

    _paragraph = paragraph.build()
      ..layout(const ui.ParagraphConstraints(width: double.infinity));
  }

  set isChecked(bool newValue) {
    if (newValue != _checked) {
      _checked = newValue;
      markNeedsPaint();
    }
  }

  set text(String newValue) {
    if (newValue != _text) {
      _text = newValue;
      resetText();
      markNeedsPaint();
    }
  }
}
