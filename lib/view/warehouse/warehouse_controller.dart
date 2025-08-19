import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_repo.dart';
import 'package:spa_project/view/warehouse/warehouse_cubit.dart';

class WarehouseController extends BaseController with Repository {
  WarehouseController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cName = TextEditingController();
  TextEditingController cDescribe = TextEditingController();

  @override
  void onInitState() {
    getListRepo();
    super.onInitState();
  }

  void getListRepo({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listWarehouseAPI(1);
    if(response is Success<ModelListRepo>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<WarehouseCubit>()
            .getListWarehouseCubit(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListRepo>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onAddEditRepo({int? id, String? name, String? describe}) {
    cName.clear();
    cDescribe.clear();
    if(id != null) {
      cName = TextEditingController(text: name);
      cDescribe = TextEditingController(text: describe);
    }
    popupConfirm(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          WidgetInput(
            title: "Tên kho",
            tick: true,
            hintText: "Nhập tên kho",
            controller: cName,
          ),
          WidgetInput(
            title: "Mô tả",
            hintText: "Nhập mô tả",
            controller: cDescribe,
            maxLines: 3,
          ),
        ],
      ),
      title: id != null ? "Sửa kho hàng" : "Thêm kho hàng"
    ).confirm(onConfirm: () async {
      if(cName.text.isEmpty) return warningSnackBar(message: "Vui lòng nhập tên kho hàng");
      loadingFullScreen();
      final response = await addWarehouseAPI(id: id, name: cName.text, description: cDescribe.text);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          getListRepo(isLoad: false);
          successSnackBar(message: id == null ? "Thêm kho ${cName.text} thành công" : "Bạn vừa sửa ${cName.text} thành công");
        } else {
          errorSnackBar(message: "Không thể thêm kho ${cName.text}");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities
          .errorCodeWidget(response.errorCode))
          .normal();
      }
    });
  }

  void onDelete(int? id, String? name) {
    popupConfirm(
      content: Text("Bạn có muốn xóa kho $name?", style: TextStyles.def, textAlign: TextAlign.center)
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteWarehouseAPI(id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final list = onTriggerEvent<WarehouseCubit>().state;
          int index = list.indexWhere((item) => item.id == id);
          list.removeAt(index);
          onTriggerEvent<WarehouseCubit>().getListWarehouseCubit(list);
        } else {
          errorSnackBar(message: "Không thể xóa $name");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void openOption(Widget ui) => popupBottom(child: ui);

  @override
  void onDispose() {
    cName.dispose();
    cDescribe.dispose();
    super.onDispose();
  }
}