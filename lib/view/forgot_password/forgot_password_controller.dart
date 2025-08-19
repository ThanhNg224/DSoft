import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/arguments/to_new_pass_model.dart';
import 'package:spa_project/view/new_pass/new_pass_screen.dart';

import 'forgot_pass_cubit.dart';

class ForgotPasswordController extends BaseController with Repository {
  ForgotPasswordController(super.context);

  final TextEditingController numberController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  void onDispose() {
    numberController.dispose();
    pinController.dispose();
    super.onDispose();
  }

  void nexPage() {
    String validate = numberController.text.isEmpty
        ? "Vui lòng nhập số điện thoại" : "";
    context.read<ForgotPassCubit>().validateNumber(validate);
    if(validate.isNotEmpty) return;
    _getOtp();
  }

  void _getOtp() async {
    PopupOverlay.$LoadingFullScreen(context);
    final response = await requestCodeOtpForgotPassAPI(numberController.text);
    if (response is Success<int>) {
      hideLoading();
      final int code = response.value;
      if(code == 3) return _onError(Utilities.errorMesWidget("Email không được xác định"));
      if(code == 2) return _onError(Utilities.errorMesWidget("Số điện thoại không xác định"));
      if(code == Result.isOk) _onSuccess();
    }
    if(response is Failure<int>) {
      hideLoading();
      _onError(Utilities.errorCodeWidget(response.errorCode));
    }
  }

  void _onSuccess() async {
    Utilities.openOtpView(
      context: context,
      action: _confirmOtp,
      info: numberController.text,
      controller: pinController
    );
  }

  void _onError(Widget content) {
    popupConfirm(
      content: content
    ).normal();
  }

  void _confirmOtp() async {
    if(pinController.text.length != 4) return;
    loadingFullScreen();
    final response = await checkCodeOtAPI(numberController.text, pinController.text);
    if(response is Success<int>) {
      hideLoading();
      final int code = response.value;
      if(code == 4) _onError(Utilities.errorMesWidget("Mã xác thực nhập không chính xác, vui lòng thử lại"));
      if(code == 2) _onError(Utilities.errorMesWidget("Thông tin số điện thoại không chính xác"));
      if(code == Result.isOk) {
        pushName(NewPassScreen.router, args: ToNewPassModel(
          phone: numberController.text,
          otpCode: pinController.text
        ));
      }
    }
    if(response is Failure<int>) {
      hideLoading();
      _onError(Utilities.errorCodeWidget(response.errorCode));
    }
  }
}