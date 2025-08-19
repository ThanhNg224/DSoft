import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_debt_collection.dart' as coll;
import 'package:spa_project/model/response/model_list_collect_bill.dart' as collect_bill;
import 'package:spa_project/model/response/model_list_spend_bill.dart' as spend_bill;

class DebtManagementCubit extends Cubit<DebtManagementState> {
  DebtManagementCubit() : super(DebtManagementState());

  void changePageDebtManagement(int value)
  => emit(state.copyWith(pageIndex: value));

  void getDebtCollection(List<coll.Data> list)
  => emit(state.copyWith(listDebtCollection: list));

  void getDebtPaid(List<coll.Data> list)
  => emit(state.copyWith(listDebtPaid: list));

  void getCollectBill(List<collect_bill.Data> list)
  => emit(state.copyWith(listCollectBill: list));

  void getSpendBill(List<spend_bill.Data> list)
  => emit(state.copyWith(listSpendBill: list));
}

class DebtManagementState {
  int pageIndex;
  List<coll.Data> listDebtCollection;
  List<coll.Data> listDebtPaid;
  List<collect_bill.Data> listCollectBill;
  List<spend_bill.Data> listSpendBill;

  DebtManagementState({
    this.pageIndex = 0,
    this.listDebtCollection = const [],
    this.listDebtPaid = const [],
    this.listCollectBill = const [],
    this.listSpendBill = const [],
  });

  DebtManagementState copyWith({
    int? pageIndex,
    List<coll.Data>? listDebtCollection,
    List<coll.Data>? listDebtPaid,
    List<collect_bill.Data>? listCollectBill,
    List<spend_bill.Data>? listSpendBill,
  }) => DebtManagementState(
    pageIndex: pageIndex ?? this.pageIndex,
    listDebtCollection: listDebtCollection ?? this.listDebtCollection,
    listDebtPaid: listDebtPaid ?? this.listDebtPaid,
    listCollectBill: listCollectBill ?? this.listCollectBill,
    listSpendBill: listSpendBill ?? this.listSpendBill,
  );
}