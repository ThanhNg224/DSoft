import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_drop_dow_bed.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/request/req_use_combo.dart';
import 'package:spa_project/model/response/model_detail_order_combo.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as bed;
import 'package:spa_project/model/response/model_list_room.dart' as room;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/order/order_treatment_detail/order_treatment_detail_cubit.dart';

class OrderTreatmentDetailController extends BaseController<int> with Repository {
  OrderTreatmentDetailController(super.context);

  Widget errorWidget = const SizedBox();
  Widget errorUse = const SizedBox();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onGetDetail());
    onGetMultiApi();
    super.onInitState();
  }

  void onGetDetail() async {
    setScreenState = screenStateLoading;
    final response = await detailOrderComboAPI(args);
    if(response is Success<ModelDetailOrderCombo>) {
      if(response.value.code == Result.isOk) {
        final data = response.value;
        onTriggerEvent<OrderTreatmentDetailCubit>().getDetailOrderComboDetail(data);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelDetailOrderCombo>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onGetMultiApi() async {
    final result = await Future.wait([
      onGetListStaff(),
      onGetListBed(),
      onGetListRoom(),
    ]);
    errorUse = const SizedBox();
    for(var item in result) {
      if(!item.isNotError) {
        errorUse = item.logo;
        return;
      }
    }
  }

  Future<ExceptionMultiApi> onGetListStaff() async {
    final response = await listStaffAPI(ReqGetListStaff());
    if(response is Success<staff.ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        final listStaff = response.value.data ?? [];
        final listNewStaff = listStaff.where((e) => e.statusBed == 1).toList();
        onTriggerEvent<OrderTreatmentDetailCubit>().getListStaff(listNewStaff);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu nhân viên "));
      }
    }
    if(response is Failure<staff.ModelListStaff>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  Future<ExceptionMultiApi> onGetListBed() async {
    final response = await listBedAPI();
    if(response is Success<bed.ModelListBed>) {
      if(response.value.code == Result.isOk) {
        final listBed = response.value.data ?? [];
        final listNewBed = listBed.where((e) => e.status == 1).toList();
        onTriggerEvent<OrderTreatmentDetailCubit>().getListBed(listNewBed);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu giường & phòng"));
      }
    }
    if(response is Failure<bed.ModelListBed>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  Future<ExceptionMultiApi> onGetListRoom() async {
    final response = await listRoomAPI();
    if(response is Success<room.ModelListRoom>) {
      if(response.value.code == Result.isOk) {
        final listRoom = response.value.data ?? [];
        onTriggerEvent<OrderTreatmentDetailCubit>().getListRoom(listRoom);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Không thể lấy được dữ liệu nhân viên "));
      }
    }
    if(response is Failure<room.ModelListRoom>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  List<ModelDropDowBed> get _bedDrop {
    final state = onTriggerEvent<OrderTreatmentDetailCubit>().state;
    List<room.Data> listRoom = List.from(state.listRoom);
    List<bed.Data> listBed = List.from(state.listBed);
    List<ModelDropDowBed> result = [];

    for (var room in listRoom) {
      List<bed.Data> bedsInRoom = listBed.where((bed) => bed.idRoom == room.id).toList();
      if (bedsInRoom.isNotEmpty) {
        result.add(ModelDropDowBed(name: room.name, id: room.id, isCategory: true));
        result.addAll(bedsInRoom.map((bed) => ModelDropDowBed(name: bed.name, id: bed.id)));
      }
    }
    return result;
  }

  void onUseService(int? idService) {
    if(errorUse is !SizedBox) return popupConfirm(content: errorUse).normal();
    popupConfirm(
      title: "Xác nhận sử dụng dịch vụ",
      content: BlocProvider.value(
        value: onTriggerEvent<OrderTreatmentDetailCubit>(),
        child: BlocBuilder<OrderTreatmentDetailCubit, OrderTreatmentDetailState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetDropDow<staff.Data>(
                  title: "Chọn nhân viên",
                  topTitle: "Nhân viên",
                  content: state.listStaff.map((item) => WidgetDropSpan(value: item)).toList(),
                  getValue: (value) => value.name ?? "",
                  value: state.choseStaff,
                  onSelect: (value) => onTriggerEvent<OrderTreatmentDetailCubit>().setStaff(value),
                ),
                WidgetDropDow<ModelDropDowBed>(
                  title: "Chọn giường & phòng",
                  topTitle: "Giường & phòng",
                  content: List.generate(_bedDrop.length, (index) {
                    return WidgetDropSpan(
                        value: _bedDrop[index],
                        isCategory: _bedDrop[index].isCategory
                    );
                  }),
                  value: state.choseBed,
                  getValue: (value) => value.name ?? "",
                  onSelect: (value) => onTriggerEvent<OrderTreatmentDetailCubit>().setBed(value),
                )
              ],
            );
          }
        ),
      )
    ).confirm(onConfirm: () => _onUseServiceAction(idService));
  }

  void _onUseServiceAction(int? idService) async {
    final state = onTriggerEvent<OrderTreatmentDetailCubit>().state;
    if(state.choseBed == null && state.choseStaff == null) return warningSnackBar(message: "Vui lòng chọn nhân viên và giường & phòng");
    loadingFullScreen();
    final response = await addUserServiceAPI(ReqUseCombo(
        id: args,
        time: DateTime.now().formatDateTime(format: "HH:mm dd/MM/yyyy"),
        idStaff: state.choseStaff?.id,
        idBed: state.choseBed?.id,
        idService: idService
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        successSnackBar(message: "Bạn đã sử dụng thành công dịch vụ combo");
        pop();
      } else if(response.value == 4) {
        warningSnackBar(message: "Giường đã có khách");
      } else {
        popupConfirm(content: Utilities.errorMesWidget("Không thể sử dụng dịch vụ")).normal();
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}