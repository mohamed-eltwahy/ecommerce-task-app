import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  final Function()? onTap;
  final  EdgeInsetsGeometry? margin;
  final  Widget child;
  const AppIconButton({super.key, this.margin, required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        overlayColor: WidgetStatePropertyAll(AppColors.transparent),
        child: child,
      ),
    );
  }
}