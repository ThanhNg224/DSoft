import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_create_member.dart';
import 'package:spa_project/model/response/model_create_member.dart';
import 'package:spa_project/view/register/bloc/register_bloc.dart';

import '../login/login_controller.dart';

class RegisterController extends BaseController with Repository {
  RegisterController(super.context);

  final TextEditingController tNameSpa = TextEditingController();
  final TextEditingController tNumber = TextEditingController();
  final TextEditingController tAddress = TextEditingController();
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tConfirmPass = TextEditingController();
  final TextEditingController tPassWord = TextEditingController();

  @override
  void onDispose() {
    tNameSpa.dispose();
    tNumber.dispose();
    tAddress.dispose();
    tEmail.dispose();
    tConfirmPass.dispose();
    tPassWord.dispose();
  }

  bool _validate() {
    String vaName = tNameSpa.text.isNotEmpty ? "" : "Vui lòng nhập tên Spa của bạn";
    String vaPhone = tNumber.text.isNotEmpty ? "" : "Vui lòng nhập số điện thoại";
    String vaPass = tPassWord.text.isNotEmpty ? "" : "Vui lòng nhập mật khẩu";
    String vaConfirm = tConfirmPass.text.isNotEmpty ? "" : "Vui lòng nhập lại mật khẩu";
    if(tPassWord.text != tConfirmPass.text) vaConfirm = "Mật khẩu không trùng khớp";
    onTriggerEvent<RegisterBloc>().add(ValidateRegisterEvent(
      vaPhone: vaPhone,
      vaPassConfirm: vaConfirm,
      vaPass: vaPass,
      vaName: vaName,
    ));
    if(vaPhone.isNotEmpty
        || vaConfirm.isNotEmpty
        || vaPass.isNotEmpty
        || vaName.isNotEmpty) {
      return false;
    }
    return true;
  }

  void perform() async {
    if(!_validate()) return;
    Utilities.dismissKeyboard();
    _onRegister();
    // loadingFullScreen();
    // final response = await requestCodeOtpAPI(tNumber.text);
    // if (response is Success<int>) {
    //   hideLoading();
    //   final int code = response.value;
    //   if(code == 3) return _onError("Email không được xác định");
    //   if(code == 2) return _onError("Số điện thoại không xác định");
    //   if(code == Result.isOk) _onSuccess();
    // }
    // if(response is Failure<int>) {
    //   hideLoading();
    //   _onError(Utilities.formatExceptionError(response.errorCode));
    // }
  }

  // void _onSuccess() async {
  //   Utilities.openOtpView(
  //     context: context,
  //     action: _onRegister,
  //     info: tNumber.text,
  //   );
  // }

  void _onError(Widget content) {
    popupConfirm(
      content: content
    ).normal();
  }

  ResCreateMember createMemberModel() {
    return ResCreateMember(
        phone: tNumber.text,
        email: tEmail.text,
        address: tAddress.text,
        nameSpa: tNameSpa.text,
        password: tPassWord.text,
        passwordAgain: tConfirmPass.text
    );
  }

  void _onRegister() async {
    loadingFullScreen();
    final response = await createMemberAPI(createMemberModel());
    hideLoading();
    if(response is Success<ModelCreateMember>) {
      if(response.value.code == Result.isOk) {
        successSnackBar(message: response.value.messages);
        if(!context.mounted) return;
        Utilities.dismissKeyboard();
        Utilities.openSuccessView(
            context: context,
            textButton: "Đăng nhập",
            title: "Tài khoản của bạn đã được tạo thành công",
            subTitle: "Hãy đăng nhập để bắt đầu sử dụng ứng dụng và khám phá những tính năng hấp dẫn.",
            action: () {
              print("Login");
              findController<LoginController>()
                  .onLogin(tNumber.text, tPassWord.text);
            }
        );
      }
      if(response.value.code == 3) _onError(Utilities.errorMesWidget("Số điện thoại này đã được đăng ký"));
    } else if(response is Failure<ModelCreateMember>) {
      _onError(Utilities.errorCodeWidget(response.errorCode));
    }
  }

  // void _onLoginAfter(String phone, String pass) async {
  //   loadingFullScreen();
  //   final response = await loginAPI(ReqLogin(
  //     phone: tNumber.text,
  //     password: tPassWord.text,
  //     tokenDevice: ""
  //   ));
  //   if(response is Success<ModelUser>) {
  //     hideLoading();
  //     if(response.value.code == Result.isOk) _loginSuccess(response);
  //     if(response.value.code == 3) _loginError();
  //   } else if(response is Failure<ModelUser>) {
  //     hideLoading();
  //     popup(content: Text(Utilities.formatExceptionError(response.errorCode)));
  //   } else {
  //     hideLoading();
  //   }
  // }

}