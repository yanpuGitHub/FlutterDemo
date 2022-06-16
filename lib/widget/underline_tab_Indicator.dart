import 'package:flutter/material.dart';

class MyUnderlineTabIndicator extends Decoration {
  /// Create an underline style selected tab indicator.
  ///
  /// The [borderSide] and [insets] arguments must not be null.
  const MyUnderlineTabIndicator(
      {this.borderSide = const BorderSide(width: 2.0, color: Colors.white),
      this.isRadius = false,
      this.insets = EdgeInsets.zero,
      this.indicatorWidth = 20})
      : assert(borderSide != null),
        assert(insets != null);

  /// The color and weight of the horizontal line drawn below the selected tab.
  final BorderSide borderSide;
  final bool isRadius;

  //指示器宽度
  final double indicatorWidth;

  /// Locates the selected tab's underline relative to the tab's boundary.
  ///
  /// The [TabBar.indicatorSize] property can be used to define the
  /// tab indicator's bounds in terms of its (centered) tab widget with
  /// [TabIndicatorSize.label], or the entire tab with [TabIndicatorSize.tab].
  final EdgeInsetsGeometry insets;

  @override
  Decoration? lerpFrom(Decoration? a, double t) {
    if (a is UnderlineTabIndicator) {
      return UnderlineTabIndicator(
        borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t) ?? EdgeInsets.zero,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(Decoration? b, double t) {
    if (b is MyUnderlineTabIndicator) {
      return MyUnderlineTabIndicator(
        borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t) ?? EdgeInsets.zero,
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  _MyUnderlinePainter createBoxPainter([VoidCallback? onChanged]) {
    return _MyUnderlinePainter(this, onChanged, indicatorWidth);
  }
}

class _MyUnderlinePainter extends BoxPainter {
  //希望的宽度
  double wantWidth;

  _MyUnderlinePainter(this.decoration, VoidCallback? onChanged, this.wantWidth)
      : assert(decoration != null),
        super(onChanged);

  final MyUnderlineTabIndicator decoration;

  BorderSide get borderSide => decoration.borderSide;

  EdgeInsetsGeometry get insets => decoration.insets;

  Rect _indicatorRectFor(Rect rect, TextDirection? textDirection) {
    assert(textDirection != null);
    final Rect indicator = insets.resolve(textDirection).deflateRect(rect);

    //取中间坐标
    double cw = (indicator.left + indicator.right) / 2;
    return Rect.fromLTWH(cw - wantWidth / 2,
        indicator.bottom - borderSide.width, wantWidth, borderSide.width);
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    final TextDirection? textDirection = configuration.textDirection;
    final Rect indicator =
        _indicatorRectFor(rect, textDirection).deflate(borderSide.width / 2.0);
    final Paint paint = borderSide.toPaint()
      ..strokeCap = decoration.isRadius ? StrokeCap.round : StrokeCap.square;
    canvas.drawLine(indicator.bottomLeft, indicator.bottomRight, paint);
  }
}
