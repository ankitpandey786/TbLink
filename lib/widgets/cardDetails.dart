import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CardDetails extends StatelessWidget {
  final String title;
  dynamic value;
  double? titleSize;
  double? SubtitleSize;
  Color textColor;
  bool? isNextLine = false;
  bool? isRight = false;
  bool? isCommonColor = false;

  CardDetails({
    required this.title,
    this.value,
    this.titleSize = 15,
    this.SubtitleSize = 18,
    this.isCommonColor,
    this.isRight,
    this.isNextLine,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RichText(
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 4,
        textAlign: isRight! ? TextAlign.end : TextAlign.left,
        text: TextSpan(
            text: title,
            style: TextStyle(
                color: isCommonColor! ? textColor : Colors.black,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
                fontSize: titleSize!.sp),
            children: [
              TextSpan(
                  text: "${isNextLine! ? '\n' : ' '}${value}",
                  style: TextStyle(
                      overflow: TextOverflow.fade,
                      color: textColor,
                      fontSize: SubtitleSize!.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400))
            ]),
      ),
    );
  }
}
