import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback? onMenuPressed;
  final bool showMenu;

  const CartHeader({
    super.key,
    required this.onBackPressed,
    this.onMenuPressed,
    this.showMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          _buildBackButton(),
          SizedBox(width: 16.w),
          Expanded(child: _buildTitle()),
          SizedBox(width: 16.w),
          _buildMenuButton(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    return GestureDetector(
      onTap: onBackPressed,
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

  Widget _buildTitle() {
    return Center(
      child: Text(
        'Cart Screen',
        style: TextStyles.textViewBold18.copyWith(
          color: AppColors.textColorLight,
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    if (!showMenu) {
      return SizedBox(width: 44.w);
    }

    return GestureDetector(
      onTap: onMenuPressed,
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
}
