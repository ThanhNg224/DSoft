
part of 'multi_view_bloc.dart';

class MultiViewEvent {}

class InitMultiViewEvent extends MultiViewEvent {}

class ChangePageMultiViewEvent extends MultiViewEvent {
  int currentIndex;
  ChangePageMultiViewEvent({required this.currentIndex});
}

class ChosenSpaMultiViewEvent extends MultiViewEvent {
  Data? value;
  ChosenSpaMultiViewEvent(this.value);
}