import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/app_images.dart';
import '../../../../core/widgets/app_cached_network_image.dart';

class SeafoodHeroSection extends StatelessWidget {
  const SeafoodHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 280.h,
        margin: EdgeInsets.only(bottom: 80.h),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _buildBackgroundImage(),
            _buildOverlay(),
            _buildNavigationButtons(context),
            _buildTitle(),
            _buildCircularFeaturedItem(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return SizedBox(
      height: 320.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
        child: AppCachedNetworkImage(
          imageUrl: AppImages.seafoodAppbarImg,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return SizedBox(
      height: 320.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildBackButton(context), _buildMenuButton()],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black87,
          size: 20.sp,
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 44.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(Icons.menu, color: Colors.black87, size: 20.sp),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      top: 50.h,
      left: 0,
      right: 0,
      child: Center(
        child: Text(
          'Sea Food',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildCircularFeaturedItem() {
    return Positioned(
      bottom: -80.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 160.w,
          height: 160.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.9),
                Colors.white.withValues(alpha: 0.7),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.8),
              width: 3.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 25,
                offset: const Offset(0, 12),
                spreadRadius: 2,
              ),

              BoxShadow(
                color: Colors.white.withValues(alpha: 0.5),
                blurRadius: 10,
                offset: const Offset(-2, -2),
                spreadRadius: -5,
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.95),
                  Colors.grey.shade50,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(2.w),

                child: ClipOval(
                  child: AppCachedNetworkImage(
                    imageUrl: AppImages.seafoodcurvedimag,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
