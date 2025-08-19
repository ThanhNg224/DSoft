import 'package:spa_project/base_project/package.dart';

mixin BaseCommon {
  LangUi get langUi => LangUi();

  ColorUi get colorUi => ColorUi();

  static LangUi get initLang => LangUi();

  static ColorUi get initColor => ColorUi();

  void saveToken(String value) {
    Global.setString(MyConfig.TOKEN_STRING_KEY, value);
  }

  void clearToken() => Global.setString(MyConfig.TOKEN_STRING_KEY, "");

}

class LangUi {
  static const String _vi = "vi";
  static const String _en = "en";

  // Mã khóa giá trị chuỗi để lưu vào store: shared_preferences
  String keyEncode({required Map<String, String> kLanguage}) {
    if(kLanguage == Vi.language) return _vi;
    return _en;
  }

  // Giải mã để trả về giá trị key - value
  Map<String, String> keyDecode(String language) {
    switch (language) {
      case _vi: return Vi.language;
      default: return En.language;
    }
  }
}

class ColorUi {
  static const String _dark = "dark";
  static const String _light = "light";

  // Giải mã để trả về giá trị key - value
  Map<String, Color> keyDecode(String color) {
    switch (color) {
      case _dark: return ThemeUi.dark;
      default: return ThemeUi.light;
    }
  }

  // Mã khóa giá trị k - v thành chuỗi ("dark" hoặc "light") để lưu vào store: shared_preferences
  String keyEncode({required Map<String, Color> themeUi}) {
    if(ThemeUi.dark == themeUi) return _dark;
    return _light;
  }
}