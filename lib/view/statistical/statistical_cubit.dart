import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_bil_statistical.dart';
import 'package:spa_project/model/response/model_list_agency.dart' as agency;

class StatisticalCubit extends Cubit<StatisticalState> {
  StatisticalCubit() : super(StatisticalState());

  void getServiceStatisticalEvent(List<Data> list)
  => emit(state.copyWith(listStatisticalService: list));

  void setPageIndexStatisticalEvent(int index)
  => emit(state.copyWith(indexPage: index));

  void getAgencyEvent(List<agency.Data> list)
  => emit(state.copyWith(listAgency: list));

  void setPaymentMethodEvent(ModelPaymentMethod? value)
  => emit(state.copyWith(chosePaymentMethod: value));

  void setVaTypeEvent(String value)
  => emit(state.copyWith(vaType: value));
}

class StatisticalState {
  List<Data> listStatisticalService;
  int indexPage;
  List<agency.Data> listAgency;
  ModelPaymentMethod? chosePaymentMethod;
  String vaType;

  StatisticalState({
    this.listStatisticalService = const [],
    this.indexPage = 0,
    this.listAgency = const [],
    this.chosePaymentMethod,
    this.vaType = "",
  });

  StatisticalState copyWith({
    List<Data>? listStatisticalService,
    int? indexPage,
    List<agency.Data>? listAgency,
    ModelPaymentMethod? chosePaymentMethod,
    String? vaType,
  }) => StatisticalState(
    listStatisticalService: listStatisticalService ?? this.listStatisticalService,
    indexPage: indexPage ?? this.indexPage,
    listAgency: listAgency ?? this.listAgency,
    chosePaymentMethod: chosePaymentMethod ?? this.chosePaymentMethod,
    vaType: vaType ?? this.vaType,
  );
}