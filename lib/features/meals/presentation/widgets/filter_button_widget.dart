import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const FilterButtonWidget({super.key, this.onTap, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 48.w,
        height: height ?? 48.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Image.asset(
          AppIcons.filter,
          color: AppColors.primary,
          width: 10.w,
          height: 10.h,
        ),
      ),
    );
  }
}
