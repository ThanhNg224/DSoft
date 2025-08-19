import 'dart:io';

import 'package:flutter/services.dart';
import 'package:spa_project/base_project/package.dart';

class ServiceSaveImage {
  final String _channel = "com.dsoft/save_image";

  Future<ResultSaveImage> saveImageGallery(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      return ResultSaveImage.error("URL ảnh không hợp lệ.");
    }
    if (Platform.isAndroid) {
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        return ResultSaveImage.notPermission("Không có quyền truy cập bộ nhớ, vui lòng cấp quyền.");
      }
    }
    try {
      final response = await Dio().get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      if (response.statusCode != 200) {
        return ResultSaveImage.error("Lỗi tải ảnh từ server.");
      }
      Uint8List bytes = response.data;
      final directory = Directory('/storage/emulated/0/Pictures/DSoft/');
      if (!await directory.exists()) await directory.create(recursive: true);
      final filePath = '${directory.path}anh_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      final platform = MethodChannel(_channel);
      await platform.invokeMethod('scanFile', {'path': filePath});
      return ResultSaveImage.success();
    } catch (e) {
      return ResultSaveImage.error("Lỗi khi lưu ảnh");
    }
  }

}

class ResultSaveImage {
  bool isSuccess;
  String? message;
  bool notPermission;

  ResultSaveImage._({
    required this.isSuccess,
    this.message,
    this.notPermission = false,
  });

  factory ResultSaveImage.error(String errorMessage) {
    return ResultSaveImage._(
      isSuccess: false,
      message: errorMessage,
    );
  }

  factory ResultSaveImage.notPermission(String errorMessage) {
    return ResultSaveImage._(
      isSuccess: false,
      message: errorMessage,
      notPermission: true,
    );
  }

  factory ResultSaveImage.success() {
    return ResultSaveImage._(
      isSuccess: true,
      message: "Ảnh đã được lưu."
    );
  }
}