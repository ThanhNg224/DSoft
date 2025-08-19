
class LanguageModel {
  String hello;

  LanguageModel({
    required this.hello,
  });

  factory LanguageModel.fromMap(Map<String, String> map) {
    return LanguageModel(
      hello: map['hello'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'hello': hello,
    };
  }
}