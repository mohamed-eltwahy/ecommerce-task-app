import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppErrorWidget extends StatelessWidget {
  final String message;
  const AppErrorWidget({required this.message, super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.h,
          // child: Lottie.asset(AppLotties.error, fit: BoxFit.contain)
        ),
        SizedBox(
          width: 300.w,
          child: Text(
            message,
            style: TextStyles.textViewBold20,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}