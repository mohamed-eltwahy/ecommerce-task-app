import 'dart:io';
import 'package:ecommerce_app/core/config/app_icons.dart';
import 'package:ecommerce_app/core/enums/media_type.dart';
import 'package:ecommerce_app/core/injection/injection_container.dart';
import 'package:ecommerce_app/core/navigation/app_navigator.dart';
import 'package:ecommerce_app/core/services/media_service/media_services.dart';
import 'package:ecommerce_app/core/widgets/bottom_sheet_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadBottomSheet extends StatelessWidget {
  final Function(File file) onchange;
  const UploadBottomSheet({required this.onchange, super.key});

  static final MediaService _mediaService = sl<MediaService>();

  Future<void> _getImage(BuildContext context, AppImageSource appImageSource,) async {
    final pickedImageFile = await _mediaService.uploadImage(context, appImageSource,);
    if (pickedImageFile != null) {
      onchange(pickedImageFile);
    }
  }

  Future<void> _getMultipleFile(BuildContext context) async {
    final selectedFiles = await _mediaService.uploadFiles(context);
    if (selectedFiles != null && selectedFiles.isNotEmpty) {
      onchange(selectedFiles.whereType<File>().first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 25.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 3.5.h,
            margin: EdgeInsets.only(bottom: 15.h),
            decoration: BoxDecoration(
              color: Theme.of(context).hintColor,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
          BottomSheetCard(
            onTap: () {
              sl<AppNavigator>().pop();
              _getImage(context, AppImageSource.gallery);
            },
            icon: AppIcons.gallery,
            text: "Upload Choose Image",
          ),

          BottomSheetCard(
            onTap: () {
              sl<AppNavigator>().pop();
              _getImage(context, AppImageSource.camera);
            },
            icon: AppIcons.camera,
            text: "Upload Take Picture",
          ),

          BottomSheetCard(
            onTap: () {
              sl<AppNavigator>().pop();
              _getMultipleFile(context);
            },
            icon: AppIcons.file,
            text: "Upload Choose From Files",
          ),
        ],
      ),
    );
  }
}
