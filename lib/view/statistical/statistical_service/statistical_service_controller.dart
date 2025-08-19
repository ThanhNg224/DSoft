import 'package:spa_project/base_project/package.dart';

import '../../../model/response/model_bil_statistical.dart';
import '../statistical_cubit.dart';

class StatisticalServiceController extends BaseController with Repository {
  StatisticalServiceController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    onGetServiceMoth();
    super.onInitState();
  }

  void onGetServiceMoth({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await userServicestatisticalAPI();
    if(response is Success<ModelStatisticalTimeLine>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StatisticalCubit>()
            .getServiceStatisticalEvent(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không lấy được thống kê dịch vụ theo tháng");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelStatisticalTimeLine>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}