import 'dart:io';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_add_edit_service.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as cate;
import 'package:spa_project/model/response/model_list_service.dart' as ser;
import 'package:spa_project/view/service_add_edit/service_add_edit_cubit.dart';

class ServiceAddEditController extends BaseController<ser.Data> with Repository {
  ServiceAddEditController(super.context);
  
  Widget errorWidget = const SizedBox();
  cate.Data? valueCateSelect;
  TextEditingController cName = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cDuration = TextEditingController();
  TextEditingController cDescription = TextEditingController();
  TextEditingController cPriceForStaff = TextEditingController();
  TextEditingController cPriceForAffiliate = TextEditingController();
  TextEditingController cCode = TextEditingController();
  final ServiceImagePicker serviceImage = ServiceImagePicker();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListCategory();
      cName = TextEditingController(text: args?.name);
      cPrice = TextEditingController(text: args?.price?.toCurrency());
      cDuration = TextEditingController(text: args?.duration.toString().removeCommaMoney.toString());
      cDescription = TextEditingController(text: args?.description);
      cPriceForStaff = TextEditingController(text: args?.commissionStaffFix.toString());
      cPriceForAffiliate = TextEditingController(text: args?.commissionAffiliateFix.toString());
      cCode = TextEditingController(text: args?.code);
      context.read<ServiceAddEditCubit>().changePercent(
        commissionAffiliatePercent: args?.commissionAffiliatePercent,
        commissionStaffPercent: args?.commissionStaffPercent,
      );
      onTriggerEvent<ServiceAddEditCubit>().setImage(args?.image);
      String title = args != null ? "Cập nhật dịch vụ" : "Thêm dịch vụ";
      context.read<ServiceAddEditCubit>().setTitleApp(title);
    });
    super.onInitState();
  }

  @override
  void onDispose() {
    cName.dispose();
    cPrice.dispose();
    cDuration.dispose();
    cDescription.dispose();
    cPriceForStaff.dispose();
    cPriceForAffiliate.dispose();
    cCode.dispose();
    super.onDispose();
  }

  ReqAddEditService _request() {
    final state = context.read<ServiceAddEditCubit>().state;
    return ReqAddEditService(
      commissionStaffPercent: state.commissionStaffPercent,
      commissionAffiliatePercent: state.commissionAffiliatePercent,
      duration: cDuration.text.removeCommaMoney,
      status: state.statusService,
      name: cName.text,
      id: args?.id,
      commissionAffiliateFix: cPriceForAffiliate.text.removeCommaMoney,
      commissionStaffFix: cPriceForStaff.text.removeCommaMoney,
      description: cDescription.text,
      idCategory: valueCateSelect?.id,
      price: cPrice.text.removeCommaMoney,
      image: (){
        if(state.image == null) return null;
        if(state.image!.startsWith("http")) return null;
        return File(state.image!);
      }(),
      code: cCode.text
    );
  }

  bool _isValidate() {
    String vaName = cName.text.isEmpty ? "Vui lòng nhập tên dịch vụ" : "";
    String vaPrice = cPrice.text.isEmpty ? "Vui lòng nhập giá tiền" : "";
    String vaCate = valueCateSelect == null ? "Vui lòng chọn nhóm dịch vụ" : "";
    context.read<ServiceAddEditCubit>().setValidate(
      vaPrice: vaPrice,
      vaCate: vaCate,
      vaName: vaName
    );
    return vaName.isEmpty && vaPrice.isEmpty && vaCate.isEmpty;
  }

  void onAddEditService() async {
    if(!_isValidate()) return;
    loadingFullScreen();
    final response = await addServiceAPI(_request());
    if(response is Success<int>) {
      hideLoading();
      if(response.value == Result.isOk) {
        pop(response.value);
      } else {
        errorSnackBar(message: "Không thêm được dịch vụ");
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      popupConfirm(
        content: Utilities.errorCodeWidget(response.errorCode)
      ).normal();
    }
  }

  void getListCategory() async {
    loadingFullScreen();
    final response = await listCategoryServiceAPI();
    hideLoading();
    if(response is Success<cate.ModelListCategoryService>) {
      if(response.value.code == Result.isOk) {
        _onGetListCategorySuccess(response.value.data ?? []);
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra vui, lòng thử lại");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<cate.ModelListCategoryService>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void _onGetListCategorySuccess(List<cate.Data> listCate) {
    int index = listCate.indexWhere((item) => item.id == args?.idCategory);
    if(index >= 0) valueCateSelect = listCate[index];
    context.read<ServiceAddEditCubit>().getListCateSuccess(listCate);
  }

  void onChoseImage() async {
    loadingFullScreen();
    final item = await serviceImage.imagePicker();
    hideLoading();
    if(!item.isAllowed) {
      popupConfirm(
          content: Text("Bạn chưa cấp quyền vào bộ nhớ, hãy cấp quyền cho bộ nhớ và thử lại",
            style: TextStyles.def,
            textAlign: TextAlign.center,
          )
      ).confirm(onConfirm: serviceImage.openSettings);
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<ServiceAddEditCubit>().setImage(item.path);
    }
  }
}