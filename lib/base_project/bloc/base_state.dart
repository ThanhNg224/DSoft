part of 'base_bloc.dart';

class BaseState {
  LanguageModel? language;
  ModelThemeUi? colorUi;
  ModelMyInfo? modelMyInfo;
  bool isStart;
  List<spa.Data> listSpa;

  BaseState({
    this.language,
    this.colorUi,
    this.modelMyInfo,
    this.isStart = false,
    this.listSpa = const [],
  });

  BaseState copyWith({
    LanguageModel? language,
    ModelThemeUi? colorUi,
    ModelMyInfo? modelMyInfo,
    bool? isStart,
    List<spa.Data>? listSpa
  }) => BaseState(
    language: language ?? this.language,
    colorUi: colorUi ?? this.colorUi,
    modelMyInfo: modelMyInfo ?? this.modelMyInfo,
    isStart: isStart ?? this.isStart,
    listSpa: listSpa ?? this.listSpa,
  );
}

class InitBaseState extends BaseState {
  InitBaseState() : super(
    language: LanguageModel.fromMap(BaseCommon
        .initLang
        .keyDecode(Global
        .getString(Constant.languageStore))),
    colorUi: ModelThemeUi.fromMap(BaseCommon
        .initColor
        .keyDecode(Global
        .getString(Constant.colorGetStore))),
  );
}
