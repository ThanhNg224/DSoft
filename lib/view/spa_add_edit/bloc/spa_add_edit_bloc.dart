import 'package:spa_project/base_project/package.dart';

part 'spa_add_edit_event.dart';
part 'spa_add_edit_state.dart';

class SpaAddEditBloc extends Bloc<SpaAddEditEvent, SpaAddEditState> {
  SpaAddEditBloc() : super(InitSpaAddEditState()) {
    on<ChoseImageSpaAddEditEvent>((event, emit) {
      emit(state.copyWith(image: event.image));
    });
    on<SetTitleViewSpaAddEditEvent>((event, emit) {
      emit(state.copyWith(titleBtn: event.titleBtn, titleAppBar: event.titleAppBar));
    });
    on<ValidateSpaAddEditEvent>((event, emit) {
      emit(state.copyWith(
        vaNameSpa: event.vaNameSpa,
        vaAddress: event.vaAddress,
        vaPhone: event.vaPhone
      ));
    });
  }
}