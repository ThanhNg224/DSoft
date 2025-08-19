import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_book_calendar.dart';

class BookDetailCubit extends Cubit<Data> {
  BookDetailCubit() : super(Data());

  void onSetData(Data? data) => emit(data ?? Data());
}