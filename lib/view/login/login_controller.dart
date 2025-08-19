import 'dart:async';
import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_login.dart';
import 'package:spa_project/model/response/model_list_spa.dart';
import 'package:spa_project/model/response/model_user.dart';
import 'package:spa_project/view/chose_spa/chose_spa_controller.dart';
import 'package:spa_project/view/chose_spa/chose_spa_screen.dart';
import 'package:spa_project/view/login/bloc/login_bloc.dart';
import 'package:spa_project/view/multi_view/multi_view_screen.dart';

class LoginController extends BaseController with Repository {
  LoginController(super.context);

  TextEditingController cNumber = TextEditingController(text: Global.getString(Constant.myPhoneNumber));
  TextEditingController cPassWork = TextEditingController();
  Timer? timer;
  bool _isMoreSpa = false;

  late OnShowPassWord onShowPassWord = OnShowPassWord(this);
  late MonitorScroll monitorScroll = MonitorScroll(this);
  final ScrollController scrollLoginController = ScrollController();

  @override
  void onInitState() {
    Utilities.removeSplash();
    monitorScroll.initListener();
    _initStateRememberMe();
    super.onInitState();
  }

  @override
  void onDispose() {
    timer?.cancel();
    cNumber.dispose();
    cPassWork.dispose();
    scrollLoginController.dispose();
    super.onDispose();
  }

  void _initStateRememberMe() {
    if(Global.getString(Constant.myPhoneNumber).isNotEmpty) {
      context.read<LoginBloc>().add(RememberMeLoginEvent(true));
    }
  }

  bool _validate(String useName, String password) {
    String vaNumber = useName.isEmpty ? "Vui lòng nhập số điện thoại" : "";
    String vaPass = password.isEmpty ? "Vui lòng nhập mật khẩu" : "";
    onTriggerEvent<LoginBloc>().add(SetValidateEvent(validateNum: vaNumber, validatePass: vaPass));
    return vaNumber.isNotEmpty || vaPass.isNotEmpty;
  }

  void onLogin(String useName, String passWord) async {
    if(_validate(useName, passWord)) return;
    loadingFullScreen();
    final response = await loginAPI(ReqLogin(
        phone: useName,
        password: passWord,
        tokenDevice: "flihwhef"
    ));
    hideLoading();
    if(response is Success<ModelUser>) {
      if(response.value.code == Result.isOk || response.value.code == 5) {
        _loginSuccess(response);
        return;
      }
      if(response.value.code == 3) {
        popup(content: Utilities.errorMesWidget("Thông tin tài khoản không chính xác"));
      } else if(response.value.code == 4) {
        popup(content: Utilities.errorMesWidget("Tài khoản chưa được kích hoạt"));
      } else {
        popup(content: Utilities.errorMesWidget("Đã có lỗi xảy ra, không đăng nhập được tài khoản $useName"));
      }
    } else if(response is Failure<ModelUser>) {
      popup(content: Utilities.errorCodeWidget(response.errorCode));
    }
  }

  void _loginSuccess(Success<ModelUser> response) async {
    if(response.value.data?.token == null || response.value.data?.token == "") {
      popupConfirm(
          content: Utilities.errorMesWidget("Đây không phải lỗi của bạn, chúng tôi đang cố gắng giải quyết vấn đề này")
      ).normal();
      return;
    }
    final rememberMe = onTriggerEvent<LoginBloc>().state.rememberMe;
    final token = response.value.data?.token ?? "";
    Utilities.dismissKeyboard();
    if(token.isNotEmpty) saveToken(response.value.data!.token!);
    if(rememberMe) {
      Global.setString(Constant.myPhoneNumber, cNumber.text);
    } else {
      Global.setString(Constant.myPhoneNumber, "");
    }
    await getListSpa();
    final jsonString = Global.getString(Constant.defaultSpa);
    if (jsonString.isEmpty && _isMoreSpa) {
      pushReplacementNamed(ChoseSpaScreen.router, args: ChoseSpaController.fromLogin);
    } else {
      pushReplacementNamed(MultiViewScreen.router);
    }
    successSnackBar(message: "Đăng nhập thành công");
  }

  Future<void> getListSpa() async {
    final response = await listSpaAPI();
    if(response is Success<ModelListSpa>) {
      if(response.value.code == Result.isOk) {
        final data = response.value.data ?? [];
        onSaveListSpa(listSpa: data);
        if(data.length == 1) {
          Global.setString(Constant.defaultSpa, jsonEncode(data[0]));
          _isMoreSpa = false;
          return;
        } else {
          _isMoreSpa = true;
        }
      } else {
        warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
      }
    }
    if(response is Failure<ModelListSpa>) {
      warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
    }
  }
}

class OnShowPassWord {
  final LoginController _internal;
  OnShowPassWord(this._internal);

  void perform(bool value) {
    value = !value;
    _internal.context.read<LoginBloc>().add(OnShowPassWorkEvent(value));
  }
}

class MonitorScroll {
  final LoginController _internal;
  MonitorScroll(this._internal);

  void initListener() {
    bool isScrolling = false;
    bool lastState = false;
    _internal.scrollLoginController.addListener(() {
      if (!_internal.scrollLoginController.hasClients) return;
      isScrolling = true;
      if (isScrolling != lastState) {
        _internal.context.read<LoginBloc>().add(SetScrollingEvent(isScrolling));
        lastState = isScrolling;
      }
      _internal.timer?.cancel();
      _internal.timer = Timer(const Duration(milliseconds: 200), () {
        isScrolling = false;
        if (isScrolling != lastState) {
          _internal.context.read<LoginBloc>().add(SetScrollingEvent(isScrolling));
          lastState = isScrolling;
        }
      });
    });
  }
}