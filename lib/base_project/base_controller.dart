import 'dart:developer';
import 'package:spa_project/base_project/language/language_model.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/base_project/popup_overlay.dart';
import 'package:spa_project/base_project/base_navigator.dart';
import 'package:spa_project/base_project/screen_state.dart';
import 'package:spa_project/base_project/theme_ui/model_theme_ui.dart';
import 'package:spa_project/model/response/model_my_info.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;

import 'base_common.dart';
import 'bloc/base_bloc.dart';

class BaseController<M> with BaseCommon, ScreenState, PopupOverlay, BaseNavigator {
  BuildContext context;
  BaseController(this.context);
  BaseState get os => context.read<BaseBloc>().state;

  /// biến này để xác định có đang thực hiện request load more hay không
  bool _isLoadMore = false;
  /// Biến này để xác định có cho phép thực hiện loadmore và hiển thị loadding trên giao diện ko.
  bool isMoreEnable = true;
  bool withScrollController = false;
  /// Để sử dụng được controller cuộn màn hình tổng thể thì đặt [setEnableScrollController] = true tại hàm onInitState
  set setEnableScrollController(bool value) => withScrollController = value;
  late ScrollController scrollController;

  /// Để sử dụng biến [args] được gửi từ màn hình trước thì chỉ cần truyền genaric kiểu dữ liệu vào sau BaseController
  /// Ví dụ: class ExampleController extends BaseController<ModelSendData> {
  ///    có thể truy cập được những phần tử trong ModelSendData
  ///    Ex: args.value
  /// }
  /// BaseController<có thể truyền kiểu dữ liệu khác như int, String, ....>
  late M? args;

  /// Hàm này để khởi tạo biến [args]
  void onGetArgument() {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is M) {
      args = arguments;
    } else {
      args = null;
    }
  }

  /// Hàm này để khởi trạng thái màn hình
  void onInitState() {
    if (withScrollController) {
      scrollController = ScrollController();
      scrollController.addListener(_scrollListener);
    }
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (!_isLoadMore && isMoreEnable) {
        _isLoadMore = true;
        onLoadMore();
      }
    }
  }

  /// Ex: @override
  ///   void onRefresh() {
  ///     super.onLoadMore();
  ///     onFetchData();
  ///   }
  ///   #####################
  ///   Gọi hàm [onFetchData] sau super.onLoadMore() để thực hiện [_isLoadMore] & [isMoreEnable] trước
  Future<void> onRefresh() async {
    _isLoadMore = true;
    isMoreEnable = true;
    log("ENABLE REFRESH");
  }

  /// Ex: @override
  ///   void onLoadMore() {
  ///     _page ++;
  ///     onFetchData(page: _page);
  ///     super.onLoadMore();
  ///   }
  void onLoadMore() {
    log("ENABLE LOAD MORE");
    _isLoadMore = false;
  }

  /// Hàm hủy khi màn hình bị hủy
  void onDispose() {}

  /// Hàm thay đổi ngôn ngữ
  void onChangeLanguage({required Map<String, String> vLanguage}) async {
    loadingFullScreen();
    await Future.delayed(const Duration(milliseconds: 500));
    final language = LanguageModel.fromMap(vLanguage);
    onTriggerEvent<BaseBloc>().add(ChangeLanguageEvent(language)); // thay doi ngon ngu
    Global.setString(Constant.languageStore, langUi.keyEncode(kLanguage: vLanguage)); // Lưu vào store
    hideLoading();
  }

  /// Hàm thay đổi màu giao điện toàn hệ thống
  void onChangeColorUi({required Map<String, Color> themeUi}) {
    final color = ModelThemeUi.fromMap(themeUi);
    onTriggerEvent<BaseBloc>().add(ChangeColorUiEvent(color));
    Global.setString(Constant.colorGetStore, colorUi.keyEncode(themeUi: themeUi)); // Lưu vào store
  }

  void onSaveMyInfo({required ModelMyInfo myInfo}) {
    onTriggerEvent<BaseBloc>().add(SaveMyInfoBaseEvent(myInfo: myInfo));
  }

  void onResetMyInfo() {
    onTriggerEvent<BaseBloc>().add(InitBaseEvent());
  }

  void onSaveListSpa({required List<spa.Data> listSpa}) {
    onTriggerEvent<BaseBloc>().add(SaveListSpaEvent(listSpa: listSpa));
  }

  /// Ex use with bloc: onTriggerEvent<ExampleBloc>().add(ExampleEvent());
  /// Ex use with cubit: onTriggerEvent<ExampleCubit>().exampleFunction();
  B onTriggerEvent<B>() {
    if (!context.mounted) {
      throw Exception("Cannot use context.read<$B>() because context is unmounted.");
    }
    return context.read<B>();
  }
}