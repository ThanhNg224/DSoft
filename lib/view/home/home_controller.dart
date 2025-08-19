import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_list_book.dart';
import 'package:spa_project/model/response/model_bil_statistical.dart' as bil;
import 'package:spa_project/model/response/model_business_report.dart';
import 'package:spa_project/model/response/model_list_book.dart';
import 'package:spa_project/view/home/bloc/home_bloc.dart';
import 'package:spa_project/view/profile/profile_controller.dart';

class HomeController extends BaseController with Repository {
  HomeController(super.context);

  late BusinessReport businessReport = BusinessReport(this);
  late GetListCustomerBook customerBook = GetListCustomerBook(this);
  late GetBilStatistical bilStatistical = GetBilStatistical(this);
  Widget error = const SizedBox();

  @override
  void onInitState() {
    Utilities.removeSplash();
    onGetMulti();
    super.onInitState();
  }

  @override
  Future<void> onRefresh() async {
    super.onRefresh();
    switch(onTriggerEvent<HomeBloc>().state.page) {
      case 1:
        getOnlyBilStatistical();
      case 0:
        getOnlyBusinessReport();
        getOnlyCustomerBook();
        findController<ProfileController>().getMyInfo.perform();
    }
  }

  void onGetMulti() async {
    setScreenState = screenStateLoading;
    final resultList = await Future.wait([
      businessReport.perform(),
      customerBook.perform(),
      bilStatistical.perform(),
    ]);
    for (var item in resultList) {
      if (!item.isNotError) {
        setScreenState = screenStateError;
        error = item.logo;
        return;
      }
    }
    setScreenState = screenStateOk;
  }

  void getOnlyBusinessReport() async {
    setScreenState = screenStateLoading;
    await businessReport.perform().then((value) {
      if(!value.isNotError) {
        setScreenState = screenStateError;
        error = value.logo;
        return;
      }
      setScreenState = screenStateOk;
    });
  }

  void getOnlyCustomerBook() async {
    setScreenState = screenStateLoading;
    await customerBook.perform().then((value) {
      if(!value.isNotError) {
        setScreenState = screenStateError;
        error = value.logo;
        return;
      }
      setScreenState = screenStateOk;
    });
  }

  void getOnlyBilStatistical() async {
    setScreenState = screenStateLoading;
    await bilStatistical.perform().then((value) {
      if(!value.isNotError) {
        setScreenState = screenStateError;
        error = value.logo;
        return;
      }
      setScreenState = screenStateOk;
    });
  }
}

class BusinessReport {
  final HomeController _internal;
  BusinessReport(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.businessReportAPI();
    if(response is Success<ModelBusinessReport>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value);
        return ExceptionMultiApi.success();
      } else {
        return ExceptionMultiApi.error(logo: Utilities.errorMesWidget("Máy chủ bận!"));
      }
    }
    if(response is Failure<ModelBusinessReport>) {
      return ExceptionMultiApi.error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(ModelBusinessReport response) {
    _internal.context.read<HomeBloc>().add(GetBusinessReportHomeEvent(response));
  }
}

class GetListCustomerBook {
  final HomeController _internal;
  GetListCustomerBook(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.listBookAPI(ReqListBook());
    if(response is Success<ModelListBook>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value);
        return ExceptionMultiApi.success();
      }
      if(response.value.code == 3) {
        return ExceptionMultiApi
            .error(logo: Utilities.errorMesWidget("Hết phiên đăng nhập"));
      }
    }
    if(response is Failure<ModelListBook>) {
      return ExceptionMultiApi
          .error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(ModelListBook response) {
    _internal.context.read<HomeBloc>()
        .add(GetListCustomerBookHomeEvent(response));
  }
}

class GetBilStatistical {
  final HomeController _internal;
  GetBilStatistical(this._internal);

  Future<ExceptionMultiApi> perform() async {
    final response = await _internal.bilStatisticalAPI();
    if(response is Success<bil.ModelStatisticalTimeLine>) {
      if(response.value.code == Result.isOk) {
        _onSuccess(response.value.data ?? []);
        return ExceptionMultiApi.success();
      }
      if(response.value.code == 3) {
        return ExceptionMultiApi
            .error(logo: Utilities.errorMesWidget("Hết phiên đăng nhập"));
      }
    }
    if(response is Failure<bil.ModelStatisticalTimeLine>) {
      return ExceptionMultiApi
          .error(logo: Utilities.errorCodeWidget(response.errorCode));
    }
    return ExceptionMultiApi.success();
  }

  void _onSuccess(List<bil.Data> response) {
    _internal.context.read<HomeBloc>()
        .add(GetListBilStatistical(response));
  }
  
}