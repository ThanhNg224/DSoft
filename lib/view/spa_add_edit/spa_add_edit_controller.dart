import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_add_edit_spa.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;
import 'package:spa_project/view/spa_add_edit/bloc/spa_add_edit_bloc.dart';

import '../../model/request/req_add_edit_spa.dart';

class SpaAddEditController extends BaseController<spa.Data> with Repository {
  SpaAddEditController(super.context);

  TextEditingController cName = TextEditingController();
  TextEditingController cPhone = TextEditingController();
  TextEditingController cAddress = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cNote = TextEditingController();
  TextEditingController cFaceBook = TextEditingController();
  TextEditingController cZalo = TextEditingController();
  final ServiceImagePicker serviceImage = ServiceImagePicker();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(args);
      if(args == null) return;
      context.read<SpaAddEditBloc>().add(SetTitleViewSpaAddEditEvent(
        titleAppBar: "Cập nhật cơ sở kinh doanh",
        titleBtn: "Cập nhật"
      ));
      cName = TextEditingController(text: args?.name);
      cPhone = TextEditingController(text: args?.phone);
      cAddress = TextEditingController(text: args?.address);
      cEmail = TextEditingController(text: args?.email);
      cNote = TextEditingController(text: args?.note);
      cFaceBook = TextEditingController(text: args?.facebook);
      cZalo = TextEditingController(text: args?.zalo);
      context.read<SpaAddEditBloc>().add(ChoseImageSpaAddEditEvent(args?.image));
    });
    super.onInitState();
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
      ).confirm(onConfirm: () {
        serviceImage.openSettings();
      });
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<SpaAddEditBloc>().add(ChoseImageSpaAddEditEvent(item.path));
    }
  }

  @override
  void onDispose() {
    cName.dispose();
    cPhone.dispose();
    cAddress.dispose();
    cEmail.dispose();
    cNote.dispose();
    cFaceBook.dispose();
    cZalo.dispose();
    super.onDispose();
  }

  bool _isValidate() {
    String vaName = "";
    String vaPhone = "";
    String vaAddress = "";

    vaName = cName.text.isEmpty ? "Vui lòng nhập tên Spa" : "";
    vaPhone = cPhone.text.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    vaAddress = cAddress.text.isEmpty ? "Vui lòng nhập địa chỉ" : "";
    context.read<SpaAddEditBloc>().add(ValidateSpaAddEditEvent(
      vaPhone: vaPhone,
      vaAddress: vaAddress,
      vaNameSpa: vaName
    ));

    return vaName.isEmpty && vaPhone.isEmpty && vaAddress.isEmpty;
  }

  ReqAddEditSpa _request() {
    final image = context.read<SpaAddEditBloc>().state.image;
    return ReqAddEditSpa(
      id: args?.id,
      name: cName.text,
      email: cEmail.text,
      phone: cPhone.text,
      note: cNote.text,
      image: image,
      address: cAddress.text,
      facebook: cFaceBook.text,
      zalo: cZalo.text
    );
  }

  void onUpdateData() async {
    if(!_isValidate()) return;
    loadingFullScreen();
    final response = await addSpaAPI(_request());
    if(response is Success<ModelAddEditSpa>) {
      hideLoading();
      if(response.value.code == Result.isOk) {
        pop(response.value);
        successSnackBar(message: "Cập nhật thành công");
      }
      if(response.value.code == 3) errorSnackBar(message: "Số điện thoại đã tồn tại");
      if(response.value.code == 5) {
        popupConfirm(content: Utilities.errorMesWidget(
          "Bạn chưa có quyền thêm spa mới"
        )).normal();
      }
    }
    if(response is Failure<ModelAddEditSpa>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }


}