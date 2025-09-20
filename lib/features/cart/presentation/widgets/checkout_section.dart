import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutSection extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onCheckout;

  const CheckoutSection({
    super.key,
    required this.totalPrice,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(color: AppColors.scaffoldColorLight),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: onCheckout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.scaffoldColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Checkout',
                        style: TextStyles.textViewBold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${totalPrice.toStringAsFixed(1)} \$',
                        style: TextStyles.textViewBold16.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
