part of 'base_bloc.dart';

class BaseEvent {
  LanguageModel? language;
  ModelThemeUi? colorUi;
  BaseEvent({this.language, this.colorUi});
}

class InitBaseEvent extends BaseEvent {}

class ChangeColorUiEvent extends BaseEvent {
  ChangeColorUiEvent(ModelThemeUi colorUi) : super(colorUi: colorUi);
}

class ChangeLanguageEvent extends BaseEvent {
  ChangeLanguageEvent(LanguageModel language) : super(language: language);
}

class SaveMyInfoBaseEvent extends BaseEvent {
  ModelMyInfo? myInfo;
  SaveMyInfoBaseEvent({this.myInfo});
}

class SaveListSpaEvent extends BaseEvent {
  List<spa.Data>? listSpa;
  SaveListSpaEvent({this.listSpa});
}