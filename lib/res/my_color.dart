import 'package:spa_project/base_project/package.dart';

class MyColor {
  static const Color slateBlue = Color(0xFF696CFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color softWhite = Color(0xFFF5F5F5);
  static const Color darkNavy = Color(0xFF111827);
  static const Color slateGray = Color(0xFF687588);
  static const Color hideText = Color(0xFFA0AEC0);
  static const Color green = Color(0xFF27A376);
  static const Color red = Color(0xFFE03137);
  static const Color vividRed = Color(0xFFFF3E1D);
  static const Color yellow = Color(0xFFFFB800);
  static const Color sliver = Color(0xFFD9D9D9);
  static const Color borderInput = Color(0xFFE9EAEC);
  static const Color nowhere = Colors.transparent;
}

extension ColorOpacity on Color {
  Color get o0 => withValues(alpha: 0.0);
  Color get o1 => withValues(alpha: 0.1);
  Color get o2 => withValues(alpha: 0.2);
  Color get o3 => withValues(alpha: 0.3);
  Color get o4 => withValues(alpha: 0.4);
  Color get o5 => withValues(alpha: 0.5);
  Color get o6 => withValues(alpha: 0.6);
  Color get o7 => withValues(alpha: 0.7);
  Color get o8 => withValues(alpha: 0.8);
  Color get o9 => withValues(alpha: 0.9);
  Color get o10 => withValues(alpha: 1.0);
}

