import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppEmptyScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final String? icon;
  const AppEmptyScreen({super.key, this.title, this.description, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 25.h,),
          Text(title ?? "We are sorry", style: TextStyles.textViewRegular22,),
          Text(description ?? "Nothing Found", style: TextStyles.textViewLight14.copyWith(color: Theme.of(context).hintColor), textAlign: TextAlign.center,),
          SizedBox(height: 50.h,),
        ],
      ),
    );
  }
}