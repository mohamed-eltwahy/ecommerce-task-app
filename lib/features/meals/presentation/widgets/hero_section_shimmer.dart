import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeroSectionShimmer extends StatelessWidget {
  const HeroSectionShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 320.h,
        margin: EdgeInsets.only(bottom: 80.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background shimmer
            AppShimmer(
              child: Container(
                height: 320.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.greyTextColorLight.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32.r),
                    bottomRight: Radius.circular(32.r),
                  ),
                ),
              ),
            ),
            // Navigation buttons shimmer
            _buildNavigationShimmer(),
            // Title shimmer
            _buildTitleShimmer(),
            // Circular featured item shimmer
            _buildCircularItemShimmer(),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationShimmer() {
    return Positioned(
      top: 50.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppShimmer(
            child: ShimmerContainer(
              width: 44.w,
              height: 44.h,
              borderRadius: 12.r,
            ),
          ),
          AppShimmer(
            child: ShimmerContainer(
              width: 44.w,
              height: 44.h,
              borderRadius: 12.r,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleShimmer() {
    return Positioned(
      top: 100.h,
      left: 0,
      right: 0,
      child: Center(
        child: AppShimmer(
          child: ShimmerText(width: 120.w, height: 25.h),
        ),
      ),
    );
  }

  Widget _buildCircularItemShimmer() {
    return Positioned(
      bottom: -80.h,
      left: 0,
      right: 0,
      child: Center(
        child: AppShimmer(
          child: Container(
            width: 160.w,
            height: 160.h,
            decoration: BoxDecoration(
              color: AppColors.greyTextColorLight.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
