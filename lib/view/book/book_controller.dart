import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_book_add_edit_model.dart';
import 'package:spa_project/model/request/req_list_book.dart';
import 'package:spa_project/model/request/req_list_book_calendar.dart';
import 'package:spa_project/model/response/model_list_book.dart' as list_book;
import 'package:spa_project/model/response/model_list_book_calendar.dart' as list_cale;
import 'package:spa_project/view/book/bloc/book_bloc.dart';
import 'package:spa_project/view/book_add_edit/book_add_edit_screen.dart';

import '../book_detail/book_detail_screen.dart';

class BookController extends BaseController with Repository {
  BookController(super.context);

  Widget errorWidget = const SizedBox();
  Map<int, List<list_cale.Data>> normalizedEvents = {};
  int timestamp = 0;

  @override
  void onInitState() {
    onGetMulti(true);
    final focusedDay = context.read<BookBloc>().state.focusedDay;
    context.read<BookBloc>().add(HandleCalenderBookEvent(
      focusedDay: DateTime.now(),
      selectedDay: focusedDay,
    ));
    context.read<BookBloc>().add(SetTitleCalendarBookEvent(DateTime.now()
        .formatDateTimeToMothYear));
    super.onInitState();
  }

  void onGetMulti(bool withLoading) async {
    if(withLoading) setScreenState = screenStateLoading;
    final resultList = await Future.wait([
      onGetCustomBook(),
      onGetListBookCalendar()
    ]);
    for (var item in resultList) {
      if (!item.isNotError) {
        setScreenState = screenStateError;
        errorWidget = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  Future<ExceptionMultiApi> onGetCustomBook() async {
    final response = await listBookAPI(ReqListBook(page: 1));
    if(response is Success<list_book.ModelListBook>) {
      if(response.value.code == Result.isOk) {
        _onSuccessListBook(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra"),
        );
      }
    }
    if(response is Failure<list_book.ModelListBook>) {
      return ExceptionMultiApi.error(
        logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccessListBook(List<list_book.Data> res) {
    context.read<BookBloc>().add(GetListBookEvent(res));
  }

  Future<ExceptionMultiApi> onGetListBookCalendar() async {
    final response = await listBookCalendarAPI(ReqListBookCalendar(page: 1));
    if(response is Success<list_cale.ModelListBookCalendar>) {
      if(response.value.code == Result.isOk) {
        _onSuccessListBookCalendar(response.value);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(
          logo: Utilities.errorMesWidget("Đã có lỗi xảy ra"),
        );
      }
    }
    if(response is Failure<list_cale.ModelListBookCalendar>) {
      return ExceptionMultiApi.error(
        logo: Utilities.errorCodeWidget(response.errorCode)
      );
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccessListBookCalendar(list_cale.ModelListBookCalendar res) {
    Map<int, List<list_cale.Data>> events = {};
    for (var item in res.data ?? []) {
      // Chuyển timeBook thành DateTime
      DateTime date = DateTime.fromMillisecondsSinceEpoch(item.timeBook * 1000);
      // Chuẩn hóa về 00:00:00 (chỉ giữ ngày/tháng/năm)
      int normalizedTimestamp = DateTime(date.year, date.month, date.day)
          .millisecondsSinceEpoch ~/ 1000;
      // Nhóm các sự kiện theo ngày
      events.putIfAbsent(normalizedTimestamp, () => []).add(item);
    }
    context.read<BookBloc>().add(GetListBookCalendarEvent(
        response: res.data,
        events: events
    ));
  }

  void toAddEditBook({DateTime? time}) {
    Navigator.pushNamed(context, BookAddEditScreen.router, arguments: ToBookAddEditModel(dateTime: time)).then((value) {
      if(value == Result.isOk) onGetMulti(false);
    });
  }

  void toDetail(int? id) {
    Navigator.pushNamed(context, BookDetailScreen.router, arguments: id).then((value) {
      if(value == Result.isOk) {
        pop();
        onGetMulti(false);
      }
    });
  }
}