import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_spa.dart';
import 'package:spa_project/view/spa/bloc/spa_bloc.dart';
import 'package:spa_project/view/spa_add_edit/spa_add_edit_screen.dart';

class SpaController extends BaseController with Repository {
  SpaController(super.context);
  Widget errorView = const SizedBox();

  @override
  void onInitState() {
    getListSpa(true);
    super.onInitState();
  }

  void getListSpa(bool isReLoad) async {
    if(isReLoad) setScreenState = screenStateLoading;
    final response = await listSpaAPI();
    if(response is Success<ModelListSpa>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        setScreenState = screenStateError;
        errorView = Utilities.errorMesWidget("Không thể lấy được danh sách cơ sở kinh doanh");
      }
    }
    if(response is Failure<ModelListSpa>) {
      setScreenState = screenStateError;
      errorView = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  void _onSuccess(List<Data> value) => context
      .read<SpaBloc>()
      .add(GetListSpaEvent(value));

  void toDetail(SpaState state, int index) {
    Navigator.pushNamed(context,
      SpaAddEditScreen.router, arguments: state.listSpa[index]
    ).then((value) {
      if(value == null) return;
      getListSpa(false);
    });
  }
}
