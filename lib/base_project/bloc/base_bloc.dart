import 'package:spa_project/base_project/base_common.dart';
import 'package:spa_project/base_project/language/language_model.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/base_project/theme_ui/model_theme_ui.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;
import 'package:spa_project/model/response/model_my_info.dart';


part 'base_event.dart';
part 'base_state.dart';

class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc() : super(BaseState(
    language: LanguageModel.fromMap(BaseCommon
        .initLang
        .keyDecode(Global
        .getString(Constant.languageStore))),
    colorUi: ModelThemeUi.fromMap(BaseCommon
        .initColor
        .keyDecode(Global
        .getString(Constant.colorGetStore)))
  )) {
    on<InitBaseEvent>((event, emit) {
      emit(InitBaseState());
    });
    on<ChangeColorUiEvent>((event, emit) {
      emit(state.copyWith(colorUi: event.colorUi));
    });
    on<ChangeLanguageEvent>((event, emit) {
      emit(state.copyWith(language: event.language));
    });
    on<SaveMyInfoBaseEvent>((event, emit) {
      emit(state.copyWith(modelMyInfo: event.myInfo));
    });
    on<SaveListSpaEvent>((event, emit) {
      emit(state.copyWith(listSpa: event.listSpa));
    });
  }
}

