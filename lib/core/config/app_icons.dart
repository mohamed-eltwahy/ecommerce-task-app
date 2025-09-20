import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  AppIcons._();
  
  static const String _path = 'assets/icons/';

  // Icon paths
  static const String unseen = '${_path}unseen.svg';
  static const String seen = '${_path}seen.svg';
  static const String close = '${_path}close.svg';
  static const String camera = '${_path}camera.svg';
  static const String gallery = '${_path}gallery.svg';
  static const String file = '${_path}file.svg';
  static const String basket = '${_path}basket.png';


  // Method to render SVG as a widget
  static Widget icon({required String icon, double size = 24, Color? color}) => SvgPicture.asset(
    icon,
    width: size.w,
    height: size.h,
    colorFilter: color == null? null : ColorFilter.mode(color, BlendMode.srcIn),
  );
}