import 'dart:io';

import 'package:spa_project/base_project/package.dart';

class WidgetAvatar extends StatelessWidget {
  final String? url;
  final double? size;

  const WidgetAvatar({
    super.key,
    this.url = "",
    this.size = 33,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(child: ColoredBox(
      color: MyColor.white,
      child: _buildImage())
    );
  }
  Widget _buildImage() {
    final img = url?.trim() ?? "";
    if (img.isEmpty) {
      return _defaultAvatar();
    } else if (img.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: img,
        height: size,
        width: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => _defaultAvatar(),
        errorWidget: (context, url, error) => _defaultAvatar(),
      );
    } else {
      return Image.file(
        File(img),
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _defaultAvatar(),
      );
    }
  }

  Widget _defaultAvatar() {
    return Image.asset(
      MyImage.avatarNone,
      height: size,
      width: size,
      fit: BoxFit.cover,
    );
  }
}
