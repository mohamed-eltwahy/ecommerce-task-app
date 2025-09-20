import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealCardShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const MealCardShimmer({
    super.key,
    this.width,
    this.height,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Container(
        width: width,
        height: height ?? 200.h,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.greyTextColorLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.greyTextColorLight.withValues(alpha: 0.3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
            ),
            // Content shimmer
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title shimmer
                    ShimmerText(width: double.infinity, height: 18.h),
                    SizedBox(height: 8.h),
                    // Description shimmer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerText(width: double.infinity, height: 14.h),
                          SizedBox(height: 4.h),
                          ShimmerText(width: 150.w, height: 14.h),
                          SizedBox(height: 4.h),
                          ShimmerText(width: 100.w, height: 14.h),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // Price and button shimmer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Price shimmer
                        Row(
                          children: [
                            ShimmerText(width: 60.w, height: 18.h),
                            SizedBox(width: 8.w),
                            ShimmerText(width: 50.w, height: 16.h),
                          ],
                        ),
                        // Button shimmer
                        ShimmerContainer(
                          width: 36.w,
                          height: 36.h,
                          borderRadius: 18.r,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealListShimmer extends StatelessWidget {
  final int itemCount;
  final bool isHorizontal;

  const MealListShimmer({
    super.key,
    this.itemCount = 3,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isHorizontal) {
      return SizedBox(
        height: 200.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: MealCardShimmer(width: 160.w),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: MealCardShimmer(),
      ),
    );
  }
}
