import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protest/common/app_text_styles.dart';

import '../../common/app_colors.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.radius,
    this.height,
    this.icon,
    this.textStyle,
    this.width,
    this.color,
    this.elevation,
    this.border,
    this.gradient,
    this.replaceTextVSIcon = false,
  });

  final Function()? onPressed;
  final String text;
  final double? radius;
  final double? height;
  final double? width, elevation;
  final Widget? icon;
  final TextStyle? textStyle;
  final Color? color;
  final Gradient? gradient;
  final BoxBorder? border;
  final bool? replaceTextVSIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: color,
          minimumSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 46.h),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 7.r))),
      child: Ink(
        decoration: BoxDecoration(
            color: color,
            border: border,
            gradient: gradient ?? AppColors.gradient,
            borderRadius: BorderRadius.circular(radius ?? 7.r)),
        child: Container(
          width: width ?? MediaQuery.of(context).size.width,
          height: height ?? 46.h,
          alignment: Alignment.center,
          child: replaceTextVSIcon == false
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        text,
                        maxLines: 1,
                        style: textStyle ??
                            TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    icon ?? const SizedBox.shrink(),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon ?? const SizedBox.shrink(),
                    SizedBox(width: 4.w),
                    Text(
                      text,
                      style: textStyle ??
                          AppTextStyles.body20w4
                              .copyWith(color: AppColors.white),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
