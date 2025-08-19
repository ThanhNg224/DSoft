import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/view/custom_category/custom_cate_cubit.dart';

class CustomCateController extends BaseController with Repository {
  CustomCateController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cName = TextEditingController();

  @override
  void onInitState() {
    final list = onTriggerEvent<CustomCateCubit>().state;
    if(list.isEmpty) getListCateGory(true);
    super.onInitState();
  }

  void getListCateGory(bool isLoad) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listCategoryCustomerAPI(1);
    if(response is Success<cate.ModelCategoryCustomer>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<CustomCateCubit>().getListCate(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy danh sách danh mục khách hàng");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<cate.ModelCategoryCustomer>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void onOpenAddEditCate({int? id, String? name}) {
    cName.clear();
    if(id != null) cName = TextEditingController(text: name);
    popupConfirm(title: "Cập nhật nhóm khách hàng", content:
    WidgetInput(
      title: "Tên nhóm khách hàng",
      hintText: "Nhập tên nhóm khách hàng",
      controller: cName,
    )).confirm(onConfirm: () async {
      if(cName.text.isEmpty) return warningSnackBar(message: "Vui lòng nhập tên danh mục khách hàng");
      loadingFullScreen();
      final response = await addCategoryCustomerAPI(id: id, name: cName.text);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          getListCateGory(false);
          successSnackBar(message: "Thêm danh mục ${cName.text} thành công");
        } else {
          errorSnackBar(message: "Thêm danh mục ${cName.text} thất bại");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void onDeleteCate(int? id, {String? name}) {
    popupConfirm(
      content: Text("Xác nhận xóa danh mục $name?",
        style: TextStyles.def,
        textAlign: TextAlign.center
      ),
      title: "Xóa nhóm khách hàng"
    ).serious(onTap: () async {
      loadingFullScreen();
      final response = await deleteCategoryCustomerAPI(id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final list = onTriggerEvent<CustomCateCubit>().state;
          int index = list.indexWhere((item) => item.id == id);
          list.removeAt(index);
          onTriggerEvent<CustomCateCubit>().getListCate(list);
        } else {
          errorSnackBar(message: "Không thể xóa danh mục $name");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }
}