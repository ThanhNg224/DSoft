import 'package:spa_project/base_project/bloc/base_bloc.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_change_my_info.dart';
import 'package:spa_project/model/response/model_my_info.dart';
import 'package:spa_project/view/change_my_info/change_my_info_cubit.dart';

class ChangeMyInfoController extends BaseController with Repository {
  ChangeMyInfoController(super.context);

  final ServiceImagePicker imagePicker = ServiceImagePicker();

  late TextEditingController cName;
  late TextEditingController cPhone;
  late TextEditingController cEmail;
  late TextEditingController cAddress;

  @override
  void onInitState() {
    final myInfo = context.read<BaseBloc>().state.modelMyInfo?.data;
    cName = TextEditingController(text: myInfo?.name?.removeString(" (chủ)"));
    cPhone = TextEditingController(text: myInfo?.phone);
    cEmail = TextEditingController(text: myInfo?.email);
    cAddress = TextEditingController(text: myInfo?.address);
    super.onInitState();
  }

  @override
  void onDispose() {
    cName.dispose();
    cPhone.dispose();
    cEmail.dispose();
    cAddress.dispose();
    super.onDispose();
  }

  void onChange() async {
    loadingFullScreen();
    final response = await saveInfoMemberAPI(_body());
    if(response is Success<ModelMyInfo>) {
      hideLoading();
      if(response.value.code == Result.isOk) _onSuccess(response.value);
      if(response.value.code == 3) {
        popup(content: Utilities.errorMesWidget(response.value.messages ?? "Máy chủ bận"));
      }
    }
    if(response is Failure<ModelMyInfo>) {
      hideLoading();
      popup(content: Utilities.errorCodeWidget(response.errorCode));
    }
  }

  ReqChangeMyInfo _body() {
    final avatar = context.read<ChangeMyInfoCubit>().state;
    return ReqChangeMyInfo(
      phone: cPhone.text,
      nameSpa: cName.text,
      address: cAddress.text,
      email: cEmail.text,
      avatar: avatar
    );
  }

  void _onSuccess(ModelMyInfo res) {
    onSaveMyInfo(myInfo: res);
    Navigator.pop(context);
    successSnackBar(message: "Bạn vừa thay đổi thông tin");
  }

  void onAvatarPicker() async {
    final item = await imagePicker.imagePicker();
    if(!item.isAllowed) {
      popupConfirm(
        content: Text("Bạn chưa cấp quyền vào bộ nhớ, hãy cấp quyền cho bộ nhớ và thử lại",
          style: TextStyles.def,
          textAlign: TextAlign.center,
        )
      ).confirm(onConfirm: imagePicker.openSettings);
    }
    if(item.path.isNotEmpty) {
      onTriggerEvent<ChangeMyInfoCubit>().setAvatarChangeMyInfo(item.path);
    }
  }
}