import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String data;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? fontSize;
  final Color? color;
  final TextOverflow? overflow;

  const CustomText(this.data,
      {Key? key,
      this.fontWeight,
      this.textAlign,
      this.fontSize,
      this.color,
      this.overflow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.karla(
        fontWeight: fontWeight,
        fontSize: fontSize?.sp,
        color: color,
        textStyle: TextStyle(
          overflow: overflow,
        ),
      ),
    );
  }
}
