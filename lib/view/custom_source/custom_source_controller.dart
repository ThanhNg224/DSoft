import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;
import 'package:spa_project/view/custom_source/custom_source_cubit.dart';

class CustomSourceController extends BaseController with Repository {
  CustomSourceController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cName = TextEditingController();

  @override
  void onInitState() {
    final list = onTriggerEvent<CustomSourceCubit>().state;
    if(list.isEmpty) getListSource(true);
    super.onInitState();
  }

  void getListSource(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listSourceCustomerAPI(1);
    if(response is Success<source.ModelListSourceCustom>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<CustomSourceCubit>().getListCate(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách danh mục khách hàng");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<source.ModelListSourceCustom>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
  
  void onOpenAddEditSource({int? id, String? name}) {
    cName.clear();
    if(id != null) cName = TextEditingController(text: name);
    popupConfirm(
      content: WidgetInput(
        controller: cName,
        title: "Nguồn khách hàng",
        hintText: "Nhập nguồn khách hàng",
      ),
      title: id != null ? "Cập nhật nguồn khách hàng" : "Thêm mới nguồn khách hàng"
    ).confirm(onConfirm: () async {
      if(cName.text.isEmpty) return warningSnackBar(message: "Vui lòng nhập nguồn khách hàng");
      loadingFullScreen();
      final response = await addSourceCustomerAPI(id: id, name: cName.text);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          getListSource(false);
          successSnackBar(message: "Bạn vừa thêm nguồn khách hàng ${cName.text}");
        } else {
          errorSnackBar(message: "Không thể thêm nguồn khách hàng");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities
            .errorCodeWidget(response.errorCode))
            .normal();
      }
    });
  }

  void onDeleteSource(int? id, {String? name}) {
    popupConfirm(
      content: Text("Bạn có muốn xóa $name"),
      title: "Xóa nguồn khách hàng"
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteSourceCustomerAPI(id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          successSnackBar(message: "Bạn vừa xóa $name");
          final list = onTriggerEvent<CustomSourceCubit>().state;
          int index = list.indexWhere((item) => item.id == id);
          list.removeAt(index);
          onTriggerEvent<CustomSourceCubit>().getListCate(list);
        } else {
          errorSnackBar(message: "Lỗi không thể xóa $name");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

}