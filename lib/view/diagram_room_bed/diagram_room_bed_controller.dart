import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_active_bed.dart';
import 'package:spa_project/model/response/model_diagram_room_bed.dart' as dia;
import 'package:spa_project/view/diagram_room_bed/diagram_room_bed_cubit.dart';

class DiagramRoomBedController extends BaseController with Repository {
  DiagramRoomBedController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cNameBed = TextEditingController();
  late AddEditBedOfDiagram addEditBedOfDiagram = AddEditBedOfDiagram();
  late DeleteBedOfDiagram deleteBedOfDiagram = DeleteBedOfDiagram();
  late CheckOutBedOfDiagram checkOut = CheckOutBedOfDiagram();
  late CancelBedOfDiagram cancelBedOfDiagram = CancelBedOfDiagram();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onGetDiagram());
    super.onInitState();
  }

  @override
  void onDispose() {
    cNameBed.dispose();
    super.onDispose();
  }

  void onGetDiagram({bool isLoad = true}) async {
    if(isLoad) {
      setScreenState = screenStateLoading;
      loadingFullScreen();
    }
    final response = await listRoomBedAPI();
    hideLoading();
    if(response is Success<dia.ModelDiagramRoomBed>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<DiagramRoomBedCubit>().getListDiagramRoomBed(response.value.data);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách sơ đồ");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<dia.ModelDiagramRoomBed>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}

class AddEditBedOfDiagram {

  final _cl = findController<DiagramRoomBedController>();

  void perform({int? idBed, int? idRoom, String? name}) async {
    _cl.cNameBed.clear();
    if(idBed != null) _cl.cNameBed = TextEditingController(text: name);
    _cl.popupConfirm(
      title: idBed == null ? "Thêm giường" : "Sửa thông tin giường",
      content: WidgetInput(
        controller: _cl.cNameBed,
        title: "Tên giường",
        hintText: "Tên giường",
      )
    ).confirm(onConfirm: () {
      if(_cl.cNameBed.text.isEmpty) return _cl.warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
      _onAddEditBed(idRoom, idBed);
    });
  }

  void _onAddEditBed(int? idRoom, int? id) async {
    _cl.loadingFullScreen();
    final response = await _cl.addBedAPI(name: _cl.cNameBed.text, idRoom: idRoom, id: id);
    if(response is Success<int>) {
      if(response.value == Result.isOk) _cl.onGetDiagram(isLoad: false);
      if(response.value != Result.isOk) _cl.errorSnackBar(message: "Không thể thêm giường");
    }
    if(response is Failure<int>) {
      _cl.popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class DeleteBedOfDiagram {

  final _cl = findController<DiagramRoomBedController>();

  void perform({int? idRoom, String? name}) async {
    _cl.popupConfirm(
      title: "Xóa giường",
      content: Text("Bạn có chắc muốn xóa $name")
    ).serious(onTap: () {
      _onDeleteBed(idRoom);
    });
  }

  void _onDeleteBed(int? idRoom) async {
    _cl.loadingFullScreen();
    final response = await _cl.deleteBedAPI(idRoom);
    if(response is Success<int>) {
      if(response.value == Result.isOk) _cl.onGetDiagram(isLoad: false);
      if(response.value != Result.isOk) _cl.errorSnackBar(message: "Không thể xóa giường");
    }
    if(response is Failure<int>) {
      _cl.popupConfirm(
          content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class CheckOutBedOfDiagram with Repository {

  final controller = findController<DiagramRoomBedController>();

  Future<void> perform({int? idBed}) async {
    controller.loadingFullScreen();
    final response = await infoRoomBedAPI(idBed);
    controller.hideLoading();
    if(response is Success<ModelActiveBed>) {
      if(response.value.code == Result.isOk) {
        final data = response.value.data;
        controller.popupConfirm(
          title: "Check - out",
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _item("Thông tin phòng:", data?.name),
              _item("Tên khách hàng:", data?.customer?.name),
              _item("Địa chỉ:", data?.customer?.address),
              _item("Điện thoại:", data?.customer?.phone),
              _item("Email:", data?.customer?.email),
              _item("Ngày sinh:", data?.customer?.birthday),
              _item("Chưa giảm giá:", data?.order?.total?.toCurrency(suffix: "đ")),
              _item("Giảm giá:", "${data?.order?.promotion ?? 0}%"),
              _item("Tổng cộng:", data?.order?.totalPay?.toCurrency(suffix: "đ") ?? 0.toString()),
              _item("Trạng thái:", data?.order?.status.toString()),
              _item("Nhân viên:", data?.staff?.name),
              _item("Check in:", data?.timeCheckin?.formatUnixTimeToDateDDMMYYYY()),
            ],
          )
        ).confirm(onConfirm: () async {
          controller.loadingFullScreen();
          final response = await checkoutBedAPI(idBed, DateTime.now().formatDateTime());
          if(response is Success<int>) {
            if(response.value == Result.isOk) {
              controller.onGetDiagram(isLoad: false);
            } else {
              controller.errorSnackBar(message: "Không thể check out ${data?.name ?? ""}");
            }
          }
          if(response is Failure<int>) {
            controller.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
          }
        });
      } else {
        controller.errorSnackBar(message: "Không thể lấy được thông tin phòng");
      }
    }
    if(response is Failure<ModelActiveBed>) {
      controller.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }

  }

  Widget _item(String title, String? value) {
    return Row(children: [
      Expanded(child: Text(title, style: TextStyles.def.bold.colors(MyColor.slateGray).size(12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis
      )),
      const SizedBox(width: 10),
      Text(value ?? "Không có thông tin", style: TextStyles.def.bold.colors(MyColor.slateGray).size(12),
          maxLines: 1,
          overflow: TextOverflow.ellipsis
      )
    ]);
  }
}

class CancelBedOfDiagram with Repository {

  final controller = findController<DiagramRoomBedController>();

  void perform({int? idBed, String? name}) {
    controller.popupConfirm(
      title: "hủy check - in",
      content: Text("hủy check - in $name?", style: TextStyles.def)
    ).confirm(onConfirm: () async {
      controller.loadingFullScreen();
      final response = await cancelBedAPI(idBed);
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          controller.onGetDiagram(isLoad: false);
        } else {
          controller.errorSnackBar(message: "Không hủy check in $name");
        }
      }
      if(response is Failure<int>) {
        controller.popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }
}