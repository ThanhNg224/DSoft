
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_drop_dow_bed.dart';
import 'package:spa_project/model/common/model_drop_dow_service.dart';
import 'package:spa_project/model/common/model_drop_dow_staff.dart';
import 'package:spa_project/model/common/model_drop_dow_status.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as list_bed;
import 'package:spa_project/model/response/model_list_category_service.dart' as cate_service;
import 'package:spa_project/model/response/model_list_customer.dart' as list_customer;
import 'package:spa_project/model/response/model_list_room.dart' as list_room;
import 'package:spa_project/model/response/model_list_service.dart' as list_service;
import 'package:spa_project/model/response/model_list_staff.dart' as list_staff;
import 'package:spa_project/view/book_add_edit/book_add_edit_controller.dart';

part 'book_add_edit_event.dart';
part 'book_add_edit_state.dart';

class BookAddEditBloc extends Bloc<BookAddEditEvent, BookAddEditState> {
  BookAddEditBloc() : super(InitBookAddEditState(
    ModelDropDowStatus(name: "Chưa xác nhận", id: 0),
    DateTime.now(),
    ModelDropDowStaff(
      name: findController<BookAddEditController>().os.modelMyInfo?.data?.name,
      id: findController<BookAddEditController>().os.modelMyInfo?.data?.id
    ),
  )) {
    on<GetStaffBookAddEditEvent>((event, emit) {
      emit(state.copyWith(listStaff: event.listStaff));
    });
    on<GetBedBookAddEditEvent>((event, emit) {
      emit(state.copyWith(listBed: event.listBed));
    });
    on<GetServiceBookAddEditEvent>((event, emit) {
      emit(state.copyWith(listService: event.listService));
    });
    on<ChoseDropDowBookAddEditEvent>((event, emit) {
      emit(state.copyWith(
        staffValue: event.staffValue,
        bedValue: event.bedValue,
        statusValue: event.statusValue,
        serviceValue: event.serviceValue
      ));
    });
    on<GetListCategoryServiceBookAddEditEvent>((event, emit) {
      emit(state.copyWith(listCateService: event.response));
    });
    on<SetBookingTypeBookAddEditEvent>((event, emit) {
      emit(state.copyWith(
        isCare: event.isCare,
        isConsultation: event.isConsultation,
        isTherapy: event.isTherapy,
        isTreatmentPlan: event.isTreatmentPlan
      ));
    });
    on<GetListRoomBookAddEditEvent>((event, emit) {
      emit(state.copyWith(listRoom: event.listRoom));
    });
    on<SetTitleScreenBookAddEditEvent>((event, emit) {
      emit(state.copyWith(
        titleAppbar: event.titleAppbar,
        titleButton: event.titleButton
      ));
    });
    on<SetValidateBookAddEditEvent>((event, emit) {
      emit(state.copyWith(
        vaPhone: event.vaPhone,
        vaBed: event.vaBed,
        vaService: event.vaService,
        vaStaff: event.vaStaff,
        vaName: event.vaName
      ));
    });
  }
}