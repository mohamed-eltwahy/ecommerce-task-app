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
        margin: EdgeInsets.only(bottom: 40.h),
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
      height: 250.h,
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
      height: 250.h,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF6B73FF).withValues(alpha: 0.4),
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
      bottom: -50.h,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 150.w,
          height: 150.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,

            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.25),
                Colors.white.withValues(alpha: 0.1),
              ],
            ),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 25,
                offset: const Offset(0, 10),
                spreadRadius: 0,
              ),

              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 40,
                offset: const Offset(0, 20),
                spreadRadius: -5,
              ),

              BoxShadow(
                color: Colors.white.withValues(alpha: 0.6),
                blurRadius: 6,
                offset: const Offset(-1, -1),
                spreadRadius: -8,
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: 0,
                ),
              ],
            ),
            padding: EdgeInsets.all(8.w),
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(64.r),
                child: AppCachedNetworkImage(
                  imageUrl: AppImages.seafoodcurvedimag,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
