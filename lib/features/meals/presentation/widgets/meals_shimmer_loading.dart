import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealsShimmerLoading extends StatelessWidget {
  const MealsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [_buildHeroShimmer(), _buildGridShimmer()],
    );
  }

  Widget _buildHeroShimmer() {
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
            Positioned(
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
            ),
            // Title shimmer
            Positioned(
              top: 100.h,
              left: 0,
              right: 0,
              child: Center(
                child: AppShimmer(
                  child: ShimmerText(width: 120.w, height: 25.h),
                ),
              ),
            ),
            // Circular featured item shimmer
            Positioned(
              bottom: -80.h,
              left: 0,
              right: 0,
              child: Center(
                child: AppShimmer(child: ShimmerCircle(size: 160.w)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridShimmer() {
    return SliverPadding(
      padding: EdgeInsets.all(16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 16.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _buildGridCardShimmer(),
          childCount: 6, // Show 6 shimmer cards
        ),
      ),
    );
  }

  Widget _buildGridCardShimmer() {
    return AppShimmer(
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          color: AppColors.greyTextColorLight.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image shimmer
            Container(
              height: 90.h,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title shimmer
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: ShimmerText(width: double.infinity, height: 16.h),
                  ),
                  SizedBox(height: 2.h),
                  // Description shimmer
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerText(width: double.infinity, height: 12.h),
                          SizedBox(height: 4.h),
                          ShimmerText(width: 120.w, height: 12.h),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  // Price and button shimmer
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardColorLight,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16.r),
                        bottomRight: Radius.circular(16.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Price shimmer
                        Row(
                          children: [
                            ShimmerText(width: 50.w, height: 16.h),
                            SizedBox(width: 8.w),
                            ShimmerText(width: 40.w, height: 14.h),
                          ],
                        ),
                        // Button shimmer
                        ShimmerContainer(
                          width: 32.w,
                          height: 32.h,
                          borderRadius: 12.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
