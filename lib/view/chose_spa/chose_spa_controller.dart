import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_spa.dart';
import 'package:spa_project/view/book/book_controller.dart';
import 'package:spa_project/view/multi_view/multi_view_screen.dart';

class ChoseSpaController extends BaseController<String> with Repository {
  ChoseSpaController(super.context);
  static const String fromLogin = "from_login";
  static const String fromProfile = "from_profile";

  Data? dataChose;

  @override
  void onInitState() {
    Utilities.removeSplash();
    dataChose = Utilities.chosenSpa;
    if(os.listSpa.isNotEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) => getListSpa());
    super.onInitState();
  }

  Future<void> getListSpa() async {
    loadingFullScreen();
    final response = await listSpaAPI();
    hideLoading();
    if(response is Success<ModelListSpa>) {
      if(response.value.code == Result.isOk) {
        final data = response.value.data ?? [];
        onSaveListSpa(listSpa: data);
      } else {
        warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
      }
    }
    if(response is Failure<ModelListSpa>) {
      warningSnackBar(message: "Không thể lấy được danh sách cơ sở kinh doanh");
    }
  }

  void onAgree() {
    if(dataChose != null) {
      Global.setString(Constant.defaultSpa, jsonEncode(dataChose));
      // if(args == fromLogin) pushNameRemoteAll(MultiViewScreen.router);
      // if(args == fromProfile) pop();
      if(args == fromProfile) {
        pop();
        findController<BookController>().onGetMulti(true);
        findController<HomeController>().customerBook.perform();
      } else {
        pushNameRemoteAll(MultiViewScreen.router);
      }
    } else {
      warningSnackBar(message: "Vui lòng chọn 1 cơ sở kinh doanh mặc định");
    }
  }
}