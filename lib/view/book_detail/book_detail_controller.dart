import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_book_add_edit_model.dart';
import 'package:spa_project/model/request/req_check_in_book.dart';
import 'package:spa_project/model/response/model_detail_book_calendar.dart';
import 'package:spa_project/model/response/model_list_book_calendar.dart';
import 'package:spa_project/view/book_add_edit/book_add_edit_screen.dart';
import 'package:spa_project/view/book_detail/book_detail_cubit.dart';

class BookDetailController extends BaseController<int> with Repository {
  BookDetailController(super.context);

  late CheckInBook checkInBook = CheckInBook(this);
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GetDetailBook().perform();
    });
    super.onInitState();
  }

  void onDeleteBook() async {
    popupConfirm(
      content: Text("Bạn muốn xóa đặt lịch hẹn này không?", style: TextStyles.def)
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteBookAPI(args);
      if(response is Success<int>) {
        hideLoading();
        if(response.value == Result.isOk) {
          pop(response.value);
          successSnackBar(message: "Bạn vừa xóa thành công lịch hẹn");
        }
      }
      if(response is Failure<int>) {
        hideLoading();
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void toEditBook() {
    Navigator.pushNamed(context, BookAddEditScreen.router, arguments: ToBookAddEditModel(
      dataBook: context.read<BookDetailCubit>().state
    ));
  }

  void onCheckIn() => CheckInBook(this).perform();
}

class CheckInBook {
  final BookDetailController _internal;
  CheckInBook(this._internal);

  ReqCheckInBook _request(Data state) {
    return ReqCheckInBook(
      idStaff: state.members?.id,
      idBed: state.beds?.id,
      timeCheckin: DateTime.now().formatDateTime(),
      idBook: state.id,
    );
  }

  void perform() async {
    final state = _internal.context.read<BookDetailCubit>().state;
    _internal.loadingFullScreen();
    final response = await _internal.checkinbetBookAPI(_request(state));
    if(response is Success<int>) {
      _internal.hideLoading();
      if(response.value == Result.isOk) {
        _internal.successSnackBar(message: "Bạn vừa check in thành công");
        _internal.onTriggerEvent<BookDetailCubit>().onSetData(Data(
          phone: state.phone,
          name: state.name,
          id: state.id,
          status: 0,
          email: state.email,
          note: state.note,
          idCustomer: state.idCustomer,
          type2: state.type2,
          type1: state.type1,
          type3: state.type3,
          type4: state.type4,
          members: state.members,
          beds: state.beds,
          aptTimes: state.aptTimes,
          aptStep: state.aptStep,
          timeBook: state.timeBook,
          repeatBook: state.repeatBook,
          services: state.services
        ));
        return;
      }
      if(response.value == 4) {
        _internal.warningSnackBar(message: "phòng ${state.beds?.name} còn khách");
        return;
      }
      _internal.errorSnackBar(message: "Máy chủ bận");
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _internal.pop();
      _internal.errorSnackBar(message: "Máy chủ bận");
    }
  }
}

class GetDetailBook with Repository {

  final _internal = findController<BookDetailController>();

  void perform() async {
    _internal.setScreenState = _internal.screenStateLoading;
    final response = await detailBookAPI(_internal.args);
    if(response is Success<ModelDetailBookCalendar>) {
      if(response.value.code == Result.isOk) {
        _internal.setScreenState = _internal.screenStateOk;
        _internal.onTriggerEvent<BookDetailCubit>().onSetData(response.value.data);
      } else {
        _internal.errorWidget = Utilities.errorMesWidget("Không thể lấy thông tin");
        _internal.setScreenState = _internal.screenStateError;
      }
    }
    if(response is Failure<ModelDetailBookCalendar>) {
      _internal.errorWidget = Utilities.errorCodeWidget(response.errorCode);
      _internal.setScreenState = _internal.screenStateError;
    }
  }
}