part of 'book_bloc.dart';

class BookState {
  bool isShowViewTypeList;
  List<list_book.Data> listBook;
  List<list_calendar.Data>? listCalendar;
  DateTime focusedDay;
  DateTime selectedDay;
  Map<int, List<list_calendar.Data>> events;
  String titleCalendar;

  BookState({
    this.isShowViewTypeList = false,
    this.listBook = const [],
    this.listCalendar,
    this.events = const {},
    this.titleCalendar = "",
    required this.focusedDay,
    required this.selectedDay
  });

  BookState copyWith({
    bool? isShowViewTypeList,
    List<list_book.Data>? listBook,
    List<list_calendar.Data>? listCalendar,
    DateTime? focusedDay,
    DateTime? selectedDay,
    String? titleCalendar,
    Map<int, List<list_calendar.Data>>? events,
  }) => BookState(
    isShowViewTypeList: isShowViewTypeList ?? this.isShowViewTypeList,
    listBook: listBook ?? this.listBook,
    listCalendar: listCalendar ?? this.listCalendar,
    focusedDay: focusedDay ?? this.focusedDay,
    selectedDay: selectedDay ?? this.selectedDay,
    events: events ?? this.events,
    titleCalendar: titleCalendar ?? this.titleCalendar
  );
}

class InitBookState extends BookState {
  InitBookState({
    required super.focusedDay,
    required super.selectedDay
  });
}