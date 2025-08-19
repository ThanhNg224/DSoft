import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as bed;
import 'package:spa_project/model/response/model_list_room.dart' as room;
import 'package:spa_project/view/bed_room/bloc/bed_room_bloc.dart';

class BedRoomController extends BaseController with Repository {
  BedRoomController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cNameRoom = TextEditingController();
  TextEditingController cNameBed = TextEditingController();
  room.Data? roomValueChose;

  late GetListRoomOfBedRoom getListRoom = GetListRoomOfBedRoom(context);
  late GetListBedOfBedRoom getListBed = GetListBedOfBedRoom(context);
  late AddEditRoomOfBedRoom addEditRoom = AddEditRoomOfBedRoom(this);
  late AddEditBedOfBedRoom addEditBed = AddEditBedOfBedRoom(context);

  @override
  void onInitState() {
    onGetMultiple(true);
    super.onInitState();
  }

  @override
  void onDispose() {
    cNameRoom.dispose();
    cNameBed.dispose();
    super.onDispose();
  }

  void onGetMultiple(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final eList = await Future.wait([
      GetListRoomOfBedRoom(context).perform(),
      GetListBedOfBedRoom(context).perform(),
    ]);
    for(var item in eList) {
      if(!item.isNotError) {
        errorWidget = item.logo;
        setScreenState = screenStateError;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void onDeleteRoom(int? id, String? name) {
    popupConfirm(
      title: "Xóa phòng",
      content: RichText(textAlign: TextAlign.center, text: TextSpan(
        children: [
          TextSpan(
            text: "Bạn có muốn xóa phòng ",
            style: TextStyles.def
          ),
          TextSpan(
            text: name,
            style: TextStyles.def.bold
          ),
          TextSpan(
            text: " không?",
            style: TextStyles.def
          )
        ]
      ))
    ).serious(onTap: () {
      RemoveRoomOfBedRoom(context).perform(id);
    });
  }

  void onDeleteBed(int? id, String? name) {
    popupConfirm(
      title: "Xóa giường",
      content: RichText(textAlign: TextAlign.center, text: TextSpan(
        children: [
          TextSpan(
            text: "Bạn có muốn xóa giường ",
            style: TextStyles.def
          ),
          TextSpan(
            text: name,
            style: TextStyles.def.bold
          ),
          TextSpan(
            text: " không?",
            style: TextStyles.def
          )
        ]
      ))
    ).serious(onTap: () {
      RemoveBedOfBedRoom(context).perform(id);
    });
  }

  void onViewBed(int? id) {
    onTriggerEvent<BedRoomBloc>().add(SetPageIndexBedRoomEvent(1));
    final list = onTriggerEvent<BedRoomBloc>()
        .state
        .listBed
        .where((bed) => bed.idRoom == id)
        .toList();
    context.read<BedRoomBloc>().add(GetListBedBedRoomEvent(listBed: list));
  }
}

class GetListRoomOfBedRoom extends BedRoomController {
  GetListRoomOfBedRoom(super.context);

  Future<ExceptionMultiApi> perform() async {
    final response = await listRoomAPI();
    if(response is Success<room.ModelListRoom>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else if(response.value.code == 4) {
        return ExceptionMultiApi.error(logo: Utilities
            .errorMesWidget(response.value.messages ?? "Không lấy được danh sách phòng"));
      } else {
        return ExceptionMultiApi.error(logo: Utilities
            .errorMesWidget("Không lấy được danh sách phòng"));
      }
    }
    if(response is Failure<room.ModelListRoom>) {
      return ExceptionMultiApi.error(logo: Utilities
          .errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }
  
  void _onSuccess(List<room.Data> response) {
    context.read<BedRoomBloc>().add(GetListRoomBedRoomEvent(response));
  }
}

class GetListBedOfBedRoom extends BedRoomController {
  GetListBedOfBedRoom(super.context);

  Future<ExceptionMultiApi> perform({int? id}) async {
    final response = await listBedAPI();
    if(response is Success<bed.ModelListBed>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities
            .errorMesWidget("Không lấy được danh sách giường"));
      }
    }
    if(response is Failure<bed.ModelListBed>) {
      return ExceptionMultiApi.error(logo: Utilities
          .errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<bed.Data> response) {
    context.read<BedRoomBloc>().add(GetListBedBedRoomEvent(listBed: response, listBedAll: response));
  }
}

class AddEditRoomOfBedRoom {
  final BedRoomController _internal;
  AddEditRoomOfBedRoom(this._internal);

  void perform({int? id, String? name}) {
    _internal.cNameRoom = TextEditingController(text: name);
    _internal.popupConfirm(
      content: WidgetInput(
        title: "Tên phòng",
        hintText: "Nhập tên phòng",
        controller: _internal.cNameRoom,
      ),
      title: id != null ? "Sửa phòng" : "Thêm phòng"
    ).confirm(onConfirm: () {
      _addEditRoom(id);
    });
  }

  void _addEditRoom(int? id) async {
    if(_internal.cNameRoom.text.isEmpty) {
      _internal.warningSnackBar(message: "Vui lòng nhập tên phòng");
      return;
    }
    _internal.loadingFullScreen();
    final response = await _internal.addRoomAPI(id: id, name: _internal.cNameRoom.text);
    if(response is Success<int>) {
      _internal.hideLoading();
      if(response.value == Result.isOk) _internal.getListRoom.perform();
      if(response.value != Result.isOk) _internal.errorSnackBar(message: "Không thể thêm phòng");
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _internal.popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class RemoveRoomOfBedRoom extends BedRoomController {
  RemoveRoomOfBedRoom(super.context);

  void perform(int? id) async {
    loadingFullScreen();
    final response = await deleteRoomAPI(id);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        _onSuccess(id);
      } else {
        errorSnackBar(message: "Không xóa được phòng");
      }
    }
    if(response is Failure<int>) _onError(response.errorCode);
  }

  void _onSuccess(int? id) {
    List<room.Data> listRoom = List.from(context.read<BedRoomBloc>().state.listRoom);
    int index = listRoom.indexWhere((element) => element.id == id);
    listRoom.removeAt(index);
    context.read<BedRoomBloc>().add(GetListRoomBedRoomEvent(listRoom));
  }

  void _onError(int code) {
    hideLoading();
    popupConfirm(
      content: Utilities.errorCodeWidget(code)
    ).normal();
  }
}

class AddEditBedOfBedRoom extends BedRoomController {
  AddEditBedOfBedRoom(super.context);

  void perform({int? id, required BedRoomState state, int? index}) async {
    if(id != null) {
      cNameBed = TextEditingController(text: state.listBed[index!].name);
      final bedData = state.listBed[index].room;
      roomValueChose = room.Data(
        id: bedData?.id,
        name: bedData?.name,
        status: bedData?.status,
        createdAt: bedData?.createdAt,
        idMember: bedData?.idMember,
        idSpa: bedData?.idSpa,
      );
    }
    popupConfirm(
      title: id != null ? "Sửa thông tin giường" : "Thêm giường",
      content: StatefulBuilder(
        builder: (context, stateFull) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetInput(
                controller: cNameBed,
                title: "Tên giường",
                hintText: "Tên giường",
              ),
              WidgetDropDow<room.Data>(
                title: "Chọn phòng",
                topTitle: "Phòng",
                content: List.generate(state.listRoom.length, (index) {
                  return WidgetDropSpan(value: state.listRoom[index]);
                }),
                value: roomValueChose,
                getValue: (item) => item.name ?? "",
                onSelect: (item) => stateFull(()=> roomValueChose = item)
              )
            ],
          );
        }
      )
    ).confirm(onConfirm: () {
      _onAddEditBed(id);
    });
  }

  void _onAddEditBed(int? id) async {
    loadingFullScreen();
    final response = await addBedAPI(name: cNameBed.text, idRoom: roomValueChose?.id, id: id);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) getListBed.perform();
      if(response.value != Result.isOk) errorSnackBar(message: "Không thể thêm giường");
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }
}

class RemoveBedOfBedRoom extends BedRoomController {
  RemoveBedOfBedRoom(super.context);

  void perform(int? id) async {
    loadingFullScreen();
    final response = await deleteBedAPI(id);
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        _onSuccess(id);
      } else {
        errorSnackBar(message: "Không xóa được Giường");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      _onError(response.errorCode);
    }
  }

  void _onSuccess(int? id) {
    List<bed.Data> listBed = List.from(context.read<BedRoomBloc>().state.listBed);
    int index = listBed.indexWhere((element) => element.id == id);
    listBed.removeAt(index);
    context.read<BedRoomBloc>().add(GetListBedBedRoomEvent(listBed: listBed));
  }

  void _onError(int code) {
    hideLoading();
    popupConfirm(
      content: Utilities.errorCodeWidget(code)
    ).normal();
  }

}