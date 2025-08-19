part of 'multi_view_bloc.dart';

class MultiViewState {
  int currentIndex = 0;
  Data? choseData;

  MultiViewState({
    this.currentIndex = 0,
    this.choseData,
  });

  MultiViewState copyWith({
    int? currentIndex,
    Data? choseData,
  }) {
    return MultiViewState(
      currentIndex: currentIndex ?? this.currentIndex,
      choseData: choseData ?? this.choseData,
    );
  }
}

class InitMultiViewState extends MultiViewState {}