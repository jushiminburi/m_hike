import 'package:flutter/material.dart';

class EllipsisText extends StatelessWidget {
  final String? data;
  final InlineSpan? textSpan;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;

  const EllipsisText(
    String this.data, {
    Key? key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : textSpan = null,
        super(key: key);

  const EllipsisText.rich(
    InlineSpan this.textSpan, {
    Key? key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
  })  : data = null,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Text(
        data!,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow ?? TextOverflow.ellipsis,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines ?? 1,
      );
    }
    if (textSpan != null) {
      return Text.rich(
        textSpan!,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow ?? TextOverflow.ellipsis,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines ?? 1,
      );
    }
    return Container();
  }
}
