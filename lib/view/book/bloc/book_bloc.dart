
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_book.dart' as list_book;
import 'package:spa_project/model/response/model_list_book_calendar.dart' as list_calendar;

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(InitBookState(
      focusedDay: DateTime.now(),
      selectedDay: DateTime.now(),
  )) {
    on<ChangeViewBookEvent>((event, emit) {
      emit(state.copyWith(isShowViewTypeList: event.isShowViewTypeList));
    });
    on<GetListBookEvent>((event, emit) {
      emit(state.copyWith(listBook: event.response));
    });
    on<GetListBookCalendarEvent>((event, emit) {
      emit(state.copyWith(
        listCalendar: event.response,
        events: event.events
      ));
    });
    on<HandleCalenderBookEvent>((event, emit) {
      emit(state.copyWith(
        selectedDay: event.selectedDay,
        focusedDay: event.focusedDay
      ));
    });
    on<SetTitleCalendarBookEvent>((event, emit) {
      emit(state.copyWith(titleCalendar: event.title));
    });
  }
}