import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/config/app_colors.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../domain/entities/meal_entity.dart';
import 'meal_customization_bottom_sheet.dart';

class GridMealCard extends StatelessWidget {
  final MealEntity meal;
  final VoidCallback? onFavoriteTap;

  const GridMealCard({super.key, required this.meal, this.onFavoriteTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCustomizationBottomSheet(context);
      },
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            Expanded(child: _buildContentSection(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          child: AppCachedNetworkImage(
            imageUrl: meal.imageUrl,
            fit: BoxFit.cover,
            height: 90.h,
            width: double.infinity,
          ),
        ),
        Positioned(
          top: 8.h,
          right: 8.w,
          child: GestureDetector(
            onTap: onFavoriteTap,
            child: Icon(
              Icons.favorite_outline,
              color: AppColors.primary,
              size: 25.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Text(
            meal.name,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textColorLight,
              height: 1.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(height: 2.h),

        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              meal.description,
              style: TextStyle(
                fontSize: 11.sp,
                color: AppColors.greyTextColorLight,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),

        SizedBox(height: 6.h),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.cardColorLight,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: _buildPriceSection()),
              SizedBox(width: 8.w),
              _buildAddToCartButton(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection() {
    if (meal.priceBeforeDiscount != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '\$${meal.price.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '\$${meal.priceBeforeDiscount!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyTextColorLight,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    } else {
      return Text(
        'Price upon selection',
        style: TextStyle(
          fontSize: 12.sp,
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }

  Widget _buildAddToCartButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showCustomizationBottomSheet(context);
      },
      child: Container(
        width: 32.w,
        height: 32.h,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Icon(Icons.add, color: Colors.white, size: 18.sp),
        ),
      ),
    );
  }

  void _showCustomizationBottomSheet(BuildContext context) {
    MealCustomizationBottomSheet.show(
      context: context,
      meal: meal,
      onAddToCart: (meal, selectedOptions, quantity, totalPrice) {
        // This callback is now handled by the CartService in the bottom sheet
        // but we can add additional logic here if needed
      },
    );
  }
}
