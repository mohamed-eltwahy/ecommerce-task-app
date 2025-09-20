
import 'package:ecommerce_app/core/config/app_colors.dart';
import 'package:ecommerce_app/core/config/app_icons.dart';
import 'package:ecommerce_app/core/config/styles/styles.dart';
import 'package:ecommerce_app/core/injection/injection_container.dart';
import 'package:ecommerce_app/core/navigation/app_navigator.dart';
import 'package:flutter/material.dart';

class PopupHeader extends StatelessWidget {
  final String title;
  const PopupHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 2, child: Text(title, style: TextStyles.textViewBold14, textAlign: TextAlign.center)),
        Expanded(
          flex: 1,
          child: Align(
            alignment: AlignmentDirectional.centerEnd,
            child: InkWell(
              onTap: sl<AppNavigator>().pop,
              overlayColor: WidgetStatePropertyAll(AppColors.transparent),
              child: AppIcons.icon(icon: AppIcons.close, size: 15, color: Theme.of(context).colorScheme.onSurface)
            ),
          ),
        )
      ],
    );
  }
}