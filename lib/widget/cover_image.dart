import 'package:flutter/material.dart';

/// 封面图,如果isCircle = true, 图片的大小使用height
class CoverImage extends StatefulWidget {
  const CoverImage(
      {Key? key,
      this.isCircle = false,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.circular = 0,
      this.errorImage,
      this.holderImage,
      this.fit = BoxFit.cover,
      this.errorFit = BoxFit.cover})
      : super(key: key);

  /// 是否是圆形
  final bool isCircle;

  /// 图片url
  final String imageUrl;

  /// 图片高度
  final double height;

  /// 图片宽度
  final double width;

  /// 图片圆角
  final double circular;

  /// 错误图片
  final String? errorImage;

  /// 占位图片
  final String? holderImage;

  /// 裁剪模式
  final BoxFit fit;

  /// 错误图片裁剪模式
  final BoxFit errorFit;

  @override
  State<CoverImage> createState() => _CoverImage();
}

class _CoverImage extends State<CoverImage> {
  @override
  Widget build(BuildContext context) {
    return widget.isCircle
        ? ClipOval(
            child: image(widget.height, widget.height),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(widget.circular),
            child: image(widget.width, widget.height),
          );
  }

  Widget image(double width, double height) {
    return FadeInImage(
      width: width,
      height: height,
      fit: widget.fit,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          (null != widget.errorImage && widget.errorImage?.isNotEmpty == true)
              ? widget.errorImage ?? ""
              : "assets/images/default.png",
          fit: widget.errorFit,
          width: width,
          height: height,
        );
      },
      placeholder: AssetImage(
          (null != widget.holderImage && widget.holderImage?.isNotEmpty == true)
              ? widget.holderImage ?? ""
              : 'assets/images/default.png'),
      image: NetworkImage(widget.imageUrl),
    );
  }
}
