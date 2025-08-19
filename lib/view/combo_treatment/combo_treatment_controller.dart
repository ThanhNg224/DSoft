import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_combo.dart';
import 'package:spa_project/view/combo_treatment/add_edit/combo_add_edit_screen.dart';
import 'package:spa_project/view/combo_treatment/combo_treatment_cubit.dart';

class ComboTreatmentController extends BaseController with Repository {
  ComboTreatmentController(super.context);

  int _page = 1;
  Widget errorWidget = const SizedBox();
  List<Data> _list = [];

  @override
  void onInitState() {
    onGetListCombo();
    setEnableScrollController = true;
    super.onInitState();
  }

  Future<void> onGetListCombo({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listComboAPI(_page);
    if(response is Success<ModelListCombo>) {
      if(response.value.code == Result.isOk) {
        _list = List.from(onTriggerEvent<ComboTreatmentCubit>().state);
        if(_page == 1) _list = [];
        _list.addAll(response.value.data ?? []);
        if (_list.isEmpty || (response.value.data ?? []).length < 10) {
          isMoreEnable = false;
        } else {
          isMoreEnable = true;
        }
        setScreenState = screenStateOk;
        onTriggerEvent<ComboTreatmentCubit>().getComboTreatment(_list);
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListCombo>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void toAddEdit({Data? data}) {
    pushName(ComboAddEditScreen.router, args: data).whenComplete(() {
      onGetListCombo(isLoad: false);
    });
  }

  @override
  void onLoadMore() {
    _page ++;
    onGetListCombo(isLoad: false);
    super.onLoadMore();
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    _page = 1;
    isMoreEnable = true;
    await onGetListCombo(isLoad: false);
  }

  String remainingDays(List<Data> data, int index) {
    final createdAt = data[index].createdAt;
    if (createdAt == null) return "Không xác định";

    final expireDate = DateTime.fromMillisecondsSinceEpoch(createdAt * 1000);
    final now = DateTime.now();
    final diff = expireDate.difference(now);

    if (diff.inDays < 0) {
      return "Đã hết hạn";
    } else if (diff.inDays == 0) {
      return "Hết hạn hôm nay";
    } else {
      return "Còn ${diff.inDays} ngày";
    }
  }
}