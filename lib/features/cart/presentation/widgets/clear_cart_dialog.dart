import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';

class ClearCartDialog extends StatelessWidget {
  final VoidCallback onClear;

  const ClearCartDialog({super.key, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.scaffoldColorLight,
      title: Text(
        'Clear Cart',
        style: TextStyles.textViewBold16.copyWith(
          color: AppColors.textColorLight,
        ),
      ),
      content: Text(
        'Are you sure you want to remove all items from your cart?',
        style: TextStyles.textViewRegular14.copyWith(
          color: AppColors.greyTextColorLight,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: TextStyles.textViewRegular14.copyWith(
              color: AppColors.greyTextColorLight,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onClear();
          },
          child: Text(
            'Clear',
            style: TextStyles.textViewBold14.copyWith(color: AppColors.red),
          ),
        ),
      ],
    );
  }

  static void show({
    required BuildContext context,
    required VoidCallback onClear,
  }) {
    showDialog(
      context: context,

      builder: (context) => ClearCartDialog(onClear: onClear),
    );
  }
}
