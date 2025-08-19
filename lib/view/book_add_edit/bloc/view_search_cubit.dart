import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_customer.dart';

class ViewSearchCubit extends Cubit<ViewSearchState> {
  ViewSearchCubit() : super(ViewSearchState());

  void getListSearch(List<Data> list) {
    emit(ViewSearchState(listSearch: list));
  }

  void setLoading(bool value) => emit(ViewSearchState(isLoading: value));
}

class ViewSearchState {
  List<Data> listSearch;
  bool isLoading;

  ViewSearchState({
    this.listSearch = const [],
    this.isLoading = false
  });

  ViewSearchState copyWith({
    List<Data>? listSearch,
    bool? isLoading,
  }) => ViewSearchState(
    isLoading: isLoading ?? this.isLoading,
    listSearch: listSearch ?? this.listSearch,
  );
}