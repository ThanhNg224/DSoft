import 'package:spa_project/base_project/bloc/base_bloc.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;
import 'package:spa_project/model/response/model_logout.dart';
import 'package:spa_project/model/response/model_my_info.dart';
import 'package:spa_project/view/chose_spa/chose_spa_controller.dart';
import 'package:spa_project/view/chose_spa/chose_spa_screen.dart';
import 'package:spa_project/view/login/login_screen.dart';
import 'package:spa_project/view/multi_view/bloc/multi_view_bloc.dart';
import 'package:spa_project/view/subscription/subscription_screen.dart';

class ProfileController extends BaseController with Repository {
  ProfileController(super.context);

  late LogOutService logOut = LogOutService(this);
  late RemoveAccount removeAccount = RemoveAccount(this);
  late GetMyInfoService getMyInfo = GetMyInfoService(this);
  Widget errorWidget = const SizedBox();
  List<spa.Data> resultSpa = [];

  @override
  void onInitState() {
    getMyInfo.perform();
    super.onInitState();
  }

  void toSubscriptionScreen(ConfettiController confettiController) {
    Navigator.pushNamed(context, SubscriptionScreen.router).then((value) {
      if(value == Result.isOk) {
        confettiController.play();
        getMyInfo.perform();
        onTriggerEvent<MultiViewBloc>().add(ChangePageMultiViewEvent(currentIndex: 0));
      }
    });
  }

  // void openSpaDefault(BaseState os) async {
  //   final List<spa.Data> listSpa = List.from(os.listSpa);
  //   if(listSpa.isEmpty) await getListSpa();
  //   print("resultSpa: ${resultSpa.length}");
  //   if(resultSpa.length == 1) {
  //     popupConfirm(content: RichText(
  //       textAlign: TextAlign.center,
  //       text: TextSpan(
  //           children: [
  //             TextSpan(
  //                 text: "Hệ thống đã phát hiện bạn chỉ có một cơ sở kinh doanh. Vì vậy ",
  //                 style: TextStyles.def
  //             ),
  //             TextSpan(
  //                 text: listSpa[0].name ?? "",
  //                 style: TextStyles.def.bold
  //             ),
  //             TextSpan(
  //                 text: " sẽ được đặt làm cơ sở kinh doanh mặc định.",
  //                 style: TextStyles.def
  //             )
  //           ]
  //       )
  //     )).normal();
  //   } else {
  //     pushName(ChoseSpaScreen.router, args: ChoseSpaController.fromProfile);
  //   }
  // }

  void openSpaDefault(BaseState os) async {
    List<spa.Data> listSpa = List.from(os.listSpa);
    if (listSpa.isEmpty) {
      await getListSpa();
      listSpa = List.from(resultSpa); // <- cập nhật lại ở đây
    }

    print("resultSpa: ${resultSpa.length}");

    if (listSpa.length == 1) {
      popupConfirm(
        content: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hệ thống đã phát hiện bạn chỉ có một cơ sở kinh doanh. Vì vậy ",
                style: TextStyles.def,
              ),
              TextSpan(
                text: listSpa[0].name ?? "",
                style: TextStyles.def.bold,
              ),
              TextSpan(
                text: " sẽ được đặt làm cơ sở kinh doanh mặc định.",
                style: TextStyles.def,
              ),
            ],
          ),
        ),
      ).normal();
    } else {
      pushName(ChoseSpaScreen.router, args: ChoseSpaController.fromProfile);
    }
  }


  Future<void> getListSpa() async {
    loadingFullScreen();
    final response = await listSpaAPI();
    hideLoading();
    if(response is Success<spa.ModelListSpa>) {
      if(response.value.code == Result.isOk) {
        final data = response.value.data ?? [];
        onSaveListSpa(listSpa: data);
        resultSpa.addAll(data);
      } else {
        warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
      }
    }
    if(response is Failure<spa.ModelListSpa>) {
      warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
    }
  }

}

class LogOutService {
  final ProfileController _internal;
  LogOutService(this._internal);

  void perform() {
    _internal.popupConfirm(
      content: Text("Bạn có muốn đăng xuất tài khoản?",
        style: TextStyles.def,
        textAlign: TextAlign.center,
      )
    ).confirm(onConfirm: _onLogout);
  }
  
  void _onLogout() async {
    _internal.loadingFullScreen();
    final response = await _internal.logoutAPI();
    if(response is Success<ModelLogout>) {
      _internal.hideLoading();
      if(response.value.code == Result.isOk) _logoutSuccess();
    }
    if(response is Failure<ModelLogout>) {
      _internal.hideLoading();
      _logoutSuccess();
    }
  }

  void _logoutSuccess() {
    _internal.onResetMyInfo();
    _internal.successSnackBar(message: "Bạn vừa đăng xuất thành công");
    _internal.clearToken();
    Global.setString(Constant.defaultSpa, "");
    _internal.pushNameRemoteAll(LoginScreen.router);
  }
}

class RemoveAccount {
  final ProfileController _internal;
  RemoveAccount(this._internal);

  void perform() {
    _internal.popupConfirm(
      content: Text("Bạn chắc chắn muốn xóa tài khoản này?",
        style: TextStyles.def,
        textAlign: TextAlign.center,
      ),
    ).serious(onTap: _onDeleteAccount);
  }

  void _onDeleteAccount() async {
    _internal.loadingFullScreen();
    final response = await _internal.lockMemberAPI();
    if(response is Success<int>) {
      _internal.hideLoading();
      var code = response.value;
      if(code == 3) _onError(Utilities.errorMesWidget("Hết phiên đăng nhập"));
      if(code == Result.isOk) _onSuccess();
    }
    if(response is Failure<int>) {
      _internal.hideLoading();
      _onError(Utilities.errorCodeWidget(response.errorCode));
    }
  }

  void _onSuccess() {
    _internal.clearToken();
    _internal.warningSnackBar(message: "Bạn vừa xóa tài khoản");
    Navigator.pushNamedAndRemoveUntil(_internal.context, LoginScreen.router, (_) => true);
  }

  void _onError(Widget content) {
    _internal.popupConfirm(
      content: content
    ).normal();
  }
}

class GetMyInfoService {
  final ProfileController _internal;
  GetMyInfoService(this._internal);

  void perform() async {
    final response = await _internal.getInfoMyAPI();
    if(response is Success<ModelMyInfo>) {
      if(response.value.code == Result.isOk) {
        _internal.onSaveMyInfo(myInfo: response.value);
        _internal.saveToken(response.value.data?.token ?? "");
        Global.setInt(Constant.deadline, response.value.data?.datelineAt ?? 0);
        Global.setInt(Constant.numberSpa, response.value.data?.numberSpa ?? 0);
        _internal.setScreenState = _internal.screenStateOk;
      } else {
        _internal.errorWidget = Utilities.errorMesWidget("Máy chủ bận!");
        _internal.setScreenState = _internal.screenStateError;
      }
    }
    if(response is Failure<ModelMyInfo>) {
      _internal.errorWidget = Utilities.errorCodeWidget(response.errorCode);
      _internal.setScreenState = _internal.screenStateError;
    }
  }
}