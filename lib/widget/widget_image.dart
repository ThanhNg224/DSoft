import 'dart:io';

import 'package:spa_project/base_project/package.dart';

class WidgetImage extends StatelessWidget {
  final String? imageUrl;
  final double? height, width;
  final Widget? errorImage;
  final Widget? loadingImage;
  final BoxFit? fit;

  const WidgetImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.loadingImage,
    this.errorImage
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _errorWidget();
    }

    final isNetwork = imageUrl!.startsWith("http");

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: isNetwork ? CachedNetworkImage(
        imageUrl: imageUrl!,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        progressIndicatorBuilder: (context, url, progress) => _loadImage(),
        errorWidget: (context, url, error) => _errorWidget(),
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
      ) : Image.file(
        File(imageUrl!),
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _errorWidget(),
      ),
    );
  }

  Widget _loadImage() {
    return loadingImage ?? Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Lottie.asset(
        MyAnimation.imageLoading,
        reverse: true,
        height: 80,
        width: 80,
      ),
    );
  }

  Widget _errorWidget() {
    return errorImage ?? Image.asset(MyImage.noImage, width: width, height: height);
  }
}