import '../base_project/package.dart';

class TextStyles {
  static TextStyle def = const TextStyle(
    fontSize: 14,
    color: MyColor.darkNavy,
    fontWeight: FontWeight.w500,
    fontFamily: 'Manrope',
  );

}

class StyleAutoSizeText extends TextStyles {

  static TextStyle def = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontFamily: 'Manrope',
  );
}

extension ExtendedTextStyle on TextStyle {
  TextStyle get light {
    return copyWith(fontWeight: FontWeight.w300);
  }

  TextStyle get regular {
    return copyWith(fontWeight: FontWeight.w400);
  }

  TextStyle get medium {
    return copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle get semiBold {
    return copyWith(fontWeight: FontWeight.w600);
  }

  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.w700);
  }

  TextStyle get italic {
    return copyWith(
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
    );
  }

  TextStyle colors(Color color) {
    return copyWith(color: color);
  }

  TextStyle size(double size) {
    return copyWith(fontSize: size);
  }

  TextStyle underline({Color color = Colors.black, double thickness = 1}) {
    return copyWith(
      decoration: TextDecoration.underline,
      decorationColor: color,
      decorationThickness: thickness,
    );
  }

  TextStyle lineThrough({Color color = Colors.black, double thickness = 0.5}) {
    return copyWith(
      decoration: TextDecoration.lineThrough,
      decorationColor: color,
      decorationThickness: thickness,
    );
  }

  TextStyle boldItalic({
    Color? color,
    double? fontSize,
  }) {
    return copyWith(
      fontWeight: FontWeight.w700,
      fontStyle: FontStyle.italic,
      color: color,
      fontSize: fontSize,
    );
  }

}