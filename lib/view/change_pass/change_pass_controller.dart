import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_change_pass.dart';
import 'package:spa_project/model/response/model_my_info.dart';
import 'package:spa_project/view/change_pass/change_pass_cubit.dart';

class ChangePassController extends BaseController with Repository {
  ChangePassController(super.context);

  final TextEditingController cPassOld = TextEditingController();
  final TextEditingController cPassNew = TextEditingController();
  final TextEditingController cPassConfirm = TextEditingController();

  @override
  void onDispose() {
    cPassOld.dispose();
    cPassNew.dispose();
    cPassConfirm.dispose();
    super.onDispose();
  }

  void onChangePass() async {
    if(!_isValidate()) return;
    loadingFullScreen();
    final response = await changePasswordApi(_body());
    if(response is Success<ModelMyInfo>) {
      hideLoading();
      if(response.value.code == Result.isOk) _onSuccess(response);
      if(response.value.code == 4) {
        popup(content: Utilities.errorMesWidget(
          "Mật khẩu cũ không chính xác, vui lòng kiểm tra lại"
        ));
      }
      if(response.value.code == 3) {
        popup(content: Utilities.errorMesWidget(
          "Tài khoản không tồn tại hoặc hết phiên đăng nhập"
        ));
      }
    }
    if(response is Failure<ModelMyInfo>) {
      hideLoading();
      Utilities.errorCodeWidget(response.errorCode);
    }
  }

  ReqChangePassModel _body() => ReqChangePassModel(
    tokenDevice: "",
    currentPassword: cPassOld.text,
    newPassword: cPassNew.text,
    passwordConfirmation: cPassConfirm.text,
  );

  bool _isValidate() {
    String vaPass = cPassOld.text.isEmpty
        ? "Vui lòng nhập mật khẩu" : "";
    String vaPassNew = cPassNew.text.isEmpty
        ? "Vui lòng nhập mật khẩu mới" : "";
    String vaPassConfirm = cPassConfirm.text.isEmpty
        ? "Vui lòng nhập lại mật khẩu mới" : "";
    if(cPassNew.text != cPassConfirm.text) {
      vaPassConfirm = "Mật khẩu không trùng khớp";
    }
    context.read<ChangePassCubit>().validateChangePassEvent(
        vaPassConfirm: vaPassConfirm,
        vaPass: vaPass,
        vaPassNew: vaPassNew
    );
    if(vaPass.isNotEmpty
        || vaPassNew.isNotEmpty
        || vaPassConfirm.isNotEmpty) {
      return false;
    }
    return true;
  }

  void _onSuccess(Success<ModelMyInfo> response) {
    String token = response.value.data?.token ?? "";
    if(token.isNotEmpty) saveToken(token);
    onSaveMyInfo(myInfo: response.value);
    Navigator.pop(context);
    successSnackBar(message: "Bạn đã thay đổi mật khẩu thành công");
  }

}