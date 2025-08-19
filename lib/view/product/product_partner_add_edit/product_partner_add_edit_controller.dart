import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_a_e_partner.dart';
import 'package:spa_project/model/response/model_partner.dart';
import 'package:spa_project/view/product/product_partner/product_partner_controller.dart';
import 'package:spa_project/view/product/product_partner/product_partner_cubit.dart';
import 'package:spa_project/view/product/product_partner_add_edit/product_partner_add_edit_cubit.dart';

class ProductPartnerAddEditController extends BaseController<Data> with Repository {
  ProductPartnerAddEditController(super.context);

  TextEditingController cName = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cNote = TextEditingController();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(args == null) return;
      cName = TextEditingController(text: args?.name);
      cPhone = TextEditingController(text: args?.phone);
      cAddress = TextEditingController(text: args?.address);
      cEmail = TextEditingController(text: args?.email);
      cNote = TextEditingController(text: args?.note);
      onTriggerEvent<ProductPartnerAddEditCubit>().setTitleApp("Cập nhật");
    });
    super.onInitState();
  }

  bool _isValidate() {
    String vaName = cName.text.isEmpty ? "Vui lòng nhập tên nhãn hiệu" : "";
    String vaPhone = cPhone.text.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    onTriggerEvent<ProductPartnerAddEditCubit>().setValidate(
      vaName: vaName,
      vaPhone: vaPhone
    );
    return vaName.isEmpty && vaPhone.isEmpty;
  }

  void onAddEditPartner() async {
    if(!_isValidate()) return warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    loadingFullScreen();
    final response = await addPartnerAPI(ReqAEPartner(
      name: cName.text,
      id: args?.id,
      note: cNote.text,
      email: cEmail.text,
      phone: cPhone.text,
      address: cAddress.text
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
      } else {
        errorSnackBar(message: "Không thể thêm nhãn hiệu mới");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  void onDeletePartner() {
    popupConfirm(content: RichText(textAlign: TextAlign.center, text: TextSpan(
      children: [
        TextSpan(
          text: "Bạn muốn xóa nhãn hiệu ",
          style: TextStyles.def.size(16)
        ),
        TextSpan(
          text: args?.name ?? "",
          style: TextStyles.def.bold.size(16)
        )
      ]
    ))).serious(onTap: () async {
      loadingFullScreen();
      final response = await deletePartnerAPI(args?.id);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          final handle = findController<ProductPartnerController>();
          final list = handle.onTriggerEvent<ProductPartnerCubit>().state;
          int index = list.indexWhere((item) => item.id == args?.id);
          list.removeAt(index);
          handle.onTriggerEvent<ProductPartnerCubit>().getListProductPartnerCubit(list);
        } else {
          errorSnackBar(message: "Không thể xóa nhãn hiệu ${args?.name ?? ""}");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  @override
  void onDispose() {
    cName.dispose();
    cNote.dispose();
    cEmail.dispose();
    cPhone.dispose();
    cAddress.dispose();
    super.onDispose();
  }
}