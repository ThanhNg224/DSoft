import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_prepaid_card.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_add/prepaid_card_add_screen.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_cubit.dart';

class PrepaidCardController extends BaseController with Repository {
  PrepaidCardController(super.context);

  int _page = 1;
  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    getPrepaidCard();
    super.onInitState();
  }

  void getPrepaidCard({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listPrepayCardAPI(_page);
    if(response is Success<ModelPrepaidCard>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<PrepaidCardCubit>().getListPrepaidCard(response.value.data ??  []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelPrepaidCard>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void toAddPrepaidCard({Data? data}) {
    pushName(PrepaidCardAddScreen.router, args: data).then((value) {
      if(value == Result.isOk) getPrepaidCard(isLoad: false);
    });
  }

}