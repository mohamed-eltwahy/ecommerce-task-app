import 'dart:io';
import 'package:ecommerce_app/core/enums/media_type.dart';
import 'package:flutter/cupertino.dart';



abstract class MediaService {
  Future<File?> uploadImage(BuildContext context,AppImageSource appImageSource);
  Future<List<File?>?> uploadMultiImage(BuildContext context);
  Future<List<File?>?> uploadFiles(BuildContext context);
  Future<File?> compressFile(File file, {int quality = 30});
}