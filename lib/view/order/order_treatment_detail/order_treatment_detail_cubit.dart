import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_drop_dow_bed.dart';
import 'package:spa_project/model/response/model_detail_order_combo.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as bed;
import 'package:spa_project/model/response/model_list_room.dart' as room;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/order/order_treatment_detail/order_treatment_detail_controller.dart';

class OrderTreatmentDetailCubit extends Cubit<OrderTreatmentDetailState> {
  OrderTreatmentDetailCubit() : super(OrderTreatmentDetailState(
    detail: ModelDetailOrderCombo(),
    choseStaff: staff.Data(
      name: findController<OrderTreatmentDetailController>().os.modelMyInfo?.data?.name,
      id: findController<OrderTreatmentDetailController>().os.modelMyInfo?.data?.id,
    )
  ));

  void getDetailOrderComboDetail(ModelDetailOrderCombo? data)
  => emit(state.copyWith(detail: data));

  void getListRoom(List<room.Data> data)
  => emit(state.copyWith(listRoom: data));

  void getListBed(List<bed.Data> data)
  => emit(state.copyWith(listBed: data));

  void getListStaff(List<staff.Data> data)
  => emit(state.copyWith(listStaff: data));

  void setBed(ModelDropDowBed data)
  => emit(state.copyWith(choseBed: data));

  void setStaff(staff.Data data)
  => emit(state.copyWith(choseStaff: data));
}

class OrderTreatmentDetailState {
  ModelDetailOrderCombo detail;
  List<room.Data> listRoom;
  List<bed.Data> listBed;
  List<staff.Data> listStaff;
  ModelDropDowBed? choseBed;
  staff.Data choseStaff;

  OrderTreatmentDetailState({
    required this.detail,
    this.listRoom = const [],
    this.listBed = const [],
    this.listStaff = const [],
    this.choseBed,
    required this.choseStaff,
  });

  OrderTreatmentDetailState copyWith({
    ModelDetailOrderCombo? detail,
    List<room.Data>? listRoom,
    List<bed.Data>? listBed,
    List<staff.Data>? listStaff,
    ModelDropDowBed? choseBed,
    staff.Data? choseStaff,
  }) => OrderTreatmentDetailState(
    detail: detail ?? this.detail,
    listRoom: listRoom ?? this.listRoom,
    listBed: listBed ?? this.listBed,
    listStaff: listStaff ?? this.listStaff,
    choseBed: choseBed ?? this.choseBed,
    choseStaff: choseStaff ?? this.choseStaff,
  );
}