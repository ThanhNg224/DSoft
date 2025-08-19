import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_new_pass_model.dart';
import 'package:spa_project/model/request/req_new_pass.dart';
import 'package:spa_project/model/request/req_login.dart';
import 'package:spa_project/model/response/model_user.dart';
import 'package:spa_project/view/multi_view/multi_view_screen.dart';
import 'package:spa_project/view/new_pass/bloc/new_pass_bloc.dart';

class NewPassController extends BaseController<ToNewPassModel> with Repository {
  NewPassController(super.context);

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void onChangePass() async {
    if(!_validate()) return;
    loadingFullScreen();
    final response = await saveNewPassAPI(_createModel());
    if(response is Success<int>) {
      hideLoading();
      final int code = response.value;
      if(code == 4) popup(content: Utilities.errorMesWidget("Mã xác thực đã hết hạn"));
      if(code == Result.isOk) _onChangeSuccess();
    }
    if(response is Failure<int>) {
      hideLoading();
      popup(content: Utilities.errorCodeWidget(
        response.errorCode),
      );
    }
  }

  @override
  void onDispose() {
    passController.dispose();
    confirmController.dispose();
    super.onDispose();
  }

  bool _validate() {
    String vaPass = passController.text.isEmpty
        ? "Vui lòng nhập mật khẩu mới" : "";
    String vaConfirm = confirmController.text.isEmpty
        ? "Vui lòng nhập lại mật khẩu" : "";
    if(passController.text != confirmController.text) {
      vaConfirm = "Mật khẩu không trùng khớp";
    }
    context.read<NewPassBloc>().add(ValidateNewPassEvent(
      vaPass: vaPass,
      vaPassConfirm: vaConfirm
    ));
    return vaPass.isEmpty && vaConfirm.isEmpty ? true : false;
  }

  ReqNewPass _createModel() {
    return ReqNewPass(
      phone: args?.phone,
      code: args?.otpCode,
      passNew: passController.text,
      passAgain: confirmController.text
    );
  }

  void _onChangeSuccess() {
    Utilities.openSuccessView(
      context: context,
      textButton: "Đăng nhập",
      title: "Mật khẩu của bạn đã được thay đổi thành công",
      subTitle: "Hãy ghi nhớ mật khẩu mới và dùng mật khẩu đó để đăng nhập lại",
      action: _onLoginLast,
    );
  }

  void _onLoginLast() async {
    loadingFullScreen();
    final response = await loginAPI(ReqLogin(
      phone: args?.phone,
      tokenDevice: "dfsfe",
      password: passController.text
    ));
    if(response is Success<ModelUser>) {
      hideLoading();
      if(response.value.code == Result.isOk) {
        _onLoginSuccess(response);
      } else {
        popup(content: Utilities.errorMesWidget("Đăng nhập không thành công"));
      }
    }
    if(response is Failure<ModelUser>) {
      hideLoading();
      popup(content: Utilities.errorCodeWidget(response.errorCode));
    }
  }

  void _onLoginSuccess(Success<ModelUser> response) {
    final token = response.value.data?.token ?? "";
    if(token.isNotEmpty) saveToken(response.value.data!.token!);
    successSnackBar(message: "Đăng nhập thành công");
    Navigator.pushNamedAndRemoveUntil(context,
        MultiViewScreen.router,
            (route) => false
    );
  }
}
