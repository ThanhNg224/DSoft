import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_project/model/response/model_list_spa.dart';

part 'multi_view_event.dart';
part 'multi_view_state.dart';

class MultiViewBloc extends Bloc<MultiViewEvent, MultiViewState> {
  MultiViewBloc() : super(InitMultiViewState()) {
    on<ChangePageMultiViewEvent>((event, emit) {
      emit(state.copyWith(currentIndex: event.currentIndex));
    });
    on<InitMultiViewEvent>((event, emit) {
      emit(InitMultiViewState());
    });
    on<ChosenSpaMultiViewEvent>((event, emit) {
      emit(state.copyWith(choseData: event.value));
    });
  }
}