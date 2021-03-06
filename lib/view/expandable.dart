import 'dart:math';

import 'package:f_demo/uitls/log.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    required this.expandText,
    this.collapseText,
    this.expanded = false,
    this.onExpandedChanged,
    this.linkColor,
    this.linkEllipsis = true,
    this.linkStyle,
    this.prefixText,
    this.prefixStyle,
    this.onPrefixTap,
    this.style,
    this.textDirection,
    this.textAlign,
    this.textScaleFactor,
    this.maxLines = 2,
    this.semanticsLabel,
  })  : assert(maxLines > 0),
        super(key: key);

  /// 文本
  final String text;

  /// 展开
  final String? expandText;

  /// 收起
  final String? collapseText;

  /// 是否展开
  final bool expanded;

  /// 展开监听
  final ValueChanged<bool>? onExpandedChanged;

  /// 展开和收起颜色
  final Color? linkColor;

  /// 是否显示省略号
  final bool linkEllipsis;

  /// 展开收起文本样式
  final TextStyle? linkStyle;

  /// 显示头的文本
  final String? prefixText;

  /// 显示头的文本样式
  final TextStyle? prefixStyle;

  ///
  final VoidCallback? onPrefixTap;

  ///
  final TextStyle? style;

  ///
  final TextDirection? textDirection;

  ///
  final TextAlign? textAlign;

  ///
  final double? textScaleFactor;

  /// 文本显示的最大行数
  final int maxLines;

  ///
  final String? semanticsLabel;

  @override
  State<ExpandableText> createState() => _ExpandableText();
}

class _ExpandableText extends State<ExpandableText> {
  bool _expanded = false;
  TapGestureRecognizer? _linkTapGestureRecognizer;
  TapGestureRecognizer? _prefixTapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _linkTapGestureRecognizer = TapGestureRecognizer()..onTap = _toggleExpanded;
    _prefixTapGestureRecognizer = TapGestureRecognizer()..onTap = _prefixTapped;
  }

  @override
  void dispose() {
    _linkTapGestureRecognizer?.dispose();
    _prefixTapGestureRecognizer?.dispose();
    super.dispose();
  }

  /// 展开点击
  void _toggleExpanded() {
    setState(() => _expanded = !_expanded);
    widget.onExpandedChanged?.call(_expanded);
  }

  void _prefixTapped() {
    widget.onPrefixTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle? effectiveTextStyle = widget.style;
    if (null == widget.style || widget.style?.inherit == true) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final linkText =
        (_expanded ? widget.collapseText : widget.expandText) ?? "";

    final linkColor = widget.linkColor ??
        widget.linkStyle?.color ??
        Theme.of(context).colorScheme.onPrimary;

    final linkTextStyle =
        effectiveTextStyle?.merge(widget.linkStyle).copyWith(color: linkColor);

    final prefixText =
        null != widget.prefixText && widget.prefixText?.isNotEmpty == true
            ? "${widget.prefixText}"
            : "";

    final link = TextSpan(
      children: [
        if (!_expanded)
          TextSpan(
            text: "\u2026",
            style: widget.linkEllipsis ? linkTextStyle : effectiveTextStyle,
            recognizer: widget.linkEllipsis ? _linkTapGestureRecognizer : null,
          ),
        if (linkText.isNotEmpty)
          TextSpan(style: effectiveTextStyle, children: <TextSpan>[
            if (_expanded) const TextSpan(text: " "),
            TextSpan(
              text: linkText,
              style: linkTextStyle,
              recognizer: _linkTapGestureRecognizer,
            )
          ]),
      ],
    );

    final prefix = TextSpan(
      text: prefixText,
      style: effectiveTextStyle?.merge(widget.prefixStyle),
      recognizer: _prefixTapGestureRecognizer,
    );
    final text = TextSpan(children: [
      prefix,
      TextSpan(
        text: widget.text,
        style: effectiveTextStyle,
      ),
    ]);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        L.d("constraints = $constraints, maxWidth=$maxWidth");
        final textAlign =
            widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
        final textDirection =
            widget.textDirection ?? Directionality.of(context);
        final textScaleFactor =
            widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
        final locale = Localizations.localeOf(context);
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.maxLines,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          final position = textPainter.getPositionForOffset(
              Offset(textSize.width - linkSize.width, textSize.height));
          final endOffset =
              textPainter.getOffsetBefore(position.offset)! - prefixText.length;
          textSpan = TextSpan(style: effectiveTextStyle, children: <TextSpan>[
            prefix,
            TextSpan(
                text: _expanded
                    ? widget.text
                    : widget.text.substring(0, max(endOffset, 0))),
            link,
          ]);
        } else {
          textSpan = text;
        }
        return RichText(
            text: textSpan,
            softWrap: true,
            textDirection: textDirection,
            textAlign: textAlign,
            textScaleFactor: textScaleFactor,
            overflow: TextOverflow.clip);
      },
    );

    if (null != widget.semanticsLabel) {
      result = Semantics(
          textDirection: widget.textDirection,
          label: widget.semanticsLabel,
          child: ExcludeSemantics(
            child: result,
          ));
    }
    return result;
  }
}
