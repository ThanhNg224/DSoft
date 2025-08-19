
part of 'home_bloc.dart';

class HomeState {
  ModelBusinessReport? report;
  ModelListBook? listBook;
  List<bil.Data> listBilStatistical;
  int page;

  HomeState({
    this.report,
    this.page = 0,
    this.listBook,
    this.listBilStatistical = const []
  });

  HomeState copyWith({
    ModelBusinessReport? report,
    ModelListBook? listBook,
    List<bil.Data>? listBilStatistical,
    int? page
  }) => HomeState(
    report: report ?? this.report,
    listBook: listBook ?? this.listBook,
    listBilStatistical: listBilStatistical ?? this.listBilStatistical,
    page: page ?? this.page
  );
}

class InitHomeState extends HomeState {}