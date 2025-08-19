import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:spa_project/base_project/package.dart';

class ServiceImagePicker {
  static const int _maxImageSize = 2048;
  static const int _compressionQuality = 70;

  Future<bool> get _requestPermission async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      if (status.isGranted) return true;
      final result = await Permission.storage.request();
      return result.isGranted;
    } else if (Platform.isIOS) {
      final status = await Permission.photos.status;
      if (status.isGranted) return true;
      final result = await Permission.photos.request();
      return result.isGranted;
    }
    return false;
  }


  Future<void> openSettings() async => await openAppSettings();

  Future<ResultPicker> imagePicker() async {
    try {
      // if (!await _requestPermission) return ResultPicker(isAllowed: false);
      final XFile? pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 25,
        maxWidth: _maxImageSize.toDouble(),
        maxHeight: _maxImageSize.toDouble(),
      );
      if (pickedFile == null) return ResultPicker(path: "");
      final Uint8List imageBytes = await pickedFile.readAsBytes();
      final Uint8List? compressedBytes = await compute(
          _processImageInIsolate,
          _IsolateData(
              imageBytes: imageBytes,
              maxSize: _maxImageSize,
              quality: _compressionQuality
          )
      );
      if (compressedBytes == null) return ResultPicker(path: "");
      final File compressedFile = await _saveCompressedImage(compressedBytes);
      return ResultPicker(path: compressedFile.path);
    } catch (e, stackTrace) {
      debugPrint('ImagePicker error: $e\n$stackTrace');
      return ResultPicker(path: "", hasError: true);
    }
  }

  Future<File> _saveCompressedImage(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Uint8List? _processImageInIsolate(_IsolateData data) {
    try {
      final img.Image? image = img.decodeImage(data.imageBytes);
      if (image == null) return null;
      final img.Image resizedImage = _resizeImageInIsolate(image, data.maxSize);
      return Uint8List.fromList(
          img.encodeJpg(resizedImage, quality: data.quality)
      );
    } catch (e) {
      debugPrint('Isolate processing error: $e');
      return null;
    }
  }

  static img.Image _resizeImageInIsolate(img.Image image, int maxSize) {
    if (image.width <= maxSize && image.height <= maxSize) return image;
    return img.copyResize(
      image,
      width: image.width > maxSize ? maxSize : null,
      height: image.height > maxSize ? maxSize : null,
      maintainAspect: true,
    );
  }
}

class _IsolateData {
  final Uint8List imageBytes;
  final int maxSize;
  final int quality;

  _IsolateData({
    required this.imageBytes,
    required this.maxSize,
    required this.quality,
  });
}

class ResultPicker {
  final String path;
  final bool isAllowed;
  final bool hasError;

  ResultPicker({
    this.path = '',
    this.isAllowed = true,
    this.hasError = false,
  });
}