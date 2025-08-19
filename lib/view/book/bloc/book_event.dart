part of 'book_bloc.dart';

class BookEvent {}

class ChangeViewBookEvent extends BookEvent {
  bool isShowViewTypeList;
  ChangeViewBookEvent({required this.isShowViewTypeList});
}

class GetListBookEvent extends BookEvent {
  List<list_book.Data> response;
  GetListBookEvent(this.response);
}

class GetListBookCalendarEvent extends BookEvent {
  List<list_calendar.Data>? response;
  Map<int, List<list_calendar.Data>>? events;
  GetListBookCalendarEvent({this.response, this.events});
}

class HandleCalenderBookEvent extends BookEvent {
  DateTime? focusedDay;
  DateTime? selectedDay;
  HandleCalenderBookEvent({this.selectedDay, this.focusedDay});
}

class SetTitleCalendarBookEvent extends BookEvent {
  String? title;
  SetTitleCalendarBookEvent(this.title);
}

