import 'dart:convert';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/common/model_search_customer.dart';
import 'package:spa_project/model/request/req_bill_collect_add.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;
import 'package:spa_project/model/response/model_list_spend_bill.dart' as spend;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/book_add_edit/bloc/view_search_cubit.dart';
import 'package:spa_project/view/book_add_edit/view_search_customer.dart';
import 'package:spa_project/view/debt_management/bill_spend/bill_spend_controller.dart';
import 'package:spa_project/view/debt_management/bill_spend_add/bill_spend_add_cubit.dart';

class BillSpendAddController extends BaseController<spend.Data> with Repository {
  BillSpendAddController(super.context);

  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();
  Widget errorWidget = const SizedBox();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cNote = TextEditingController();
  ModelSearchCustomer nameCustomer = ModelSearchCustomer();

  @override
  void onDispose() {
    cPrice.dispose();
    cNote.dispose();
    super.onDispose();
  }

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getListStaff();
      if(args == null) return;
      nameCustomer = ModelSearchCustomer(
        id: args?.idCustomer,
        name: args?.fullName,
      );
      cPrice = TextEditingController(text: args?.total?.toCurrency());
      cNote = TextEditingController(text: args?.note);
      if(args?.time != null) onTriggerEvent<BillSpendAddCubit>().changeDateTimeBillSpendAdd(args!.time!.toDateTime);
      onTriggerEvent<BillSpendAddCubit>().changeChoseStaffBillSpendAdd(staff.Data(
          name: args?.staff?.name,
          id: args?.staff?.id
      ));
      final result = ModelPaymentMethod.listPaymentMethod.firstWhere(
            (item) => item.keyValue == args!.typeCollectionBill,
        orElse: () => ModelPaymentMethod(name: "Tiền mặt", keyValue: "tien_mat"),
      );
      onTriggerEvent<BillSpendAddCubit>().changeMethodPaymentBillSpendAdd(ModelPaymentMethod(
          name: result.name,
          keyValue: result.keyValue
      ));
      onTriggerEvent<BillSpendAddCubit>().changeTitleAppBarBillSpendAdd("Cập nhật phiếu chi");
    });
    super.onInitState();
  }

  void onOpenSelectDateTime(BillSpendAddState state) async {
    final time = await dateTimePicker.open(context, initTime: state.dateTimeValue);
    state.dateTimeValue = time;
  }

  void getListStaff() async {
    loadingFullScreen();
    final response = await listStaffAPI(ReqGetListStaff(page: 1));
    hideLoading();
    if(response is Success<staff.ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<BillSpendAddCubit>()
            .getListStaffBillSpendAdd(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<staff.ModelListStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onOpenViewSearch() {
    Navigator.push(context, PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 100),
      pageBuilder: (context, _, __) => BlocProvider(
        create: (_)=> ViewSearchCubit(),
        child: const ViewSearchCustomer(isLimitedByRegion: false),
      ),
      transitionsBuilder: (context, animation, _, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    )).then((value) {
      if(value == null) return;
      final data = value as ModelSearchCustomer;
      nameCustomer.name = data.name ?? "";
      nameCustomer.id = data.id;
    });
  }

  bool get _isValidator {
    String vaName = (nameCustomer.name ?? "").isEmpty ? "Vui lòng nhập khách hàng" : "";
    String vaPrice = cPrice.text.isEmpty ? "Vui lòng nhập số tiền" : "";
    String vaStaff = (onTriggerEvent<BillSpendAddCubit>().state.choseStaff == null) ? "Vui lòng chọn nhân viên" : "";
    onTriggerEvent<BillSpendAddCubit>().setValidatorBillSpendAdd(vaName, vaPrice, vaStaff);
    return vaName.isEmpty && vaPrice.isEmpty && vaStaff.isEmpty;
  }

  void onSaveBill() async {
    if(!_isValidator) return warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    final state = onTriggerEvent<BillSpendAddCubit>().state;
    loadingFullScreen();

    final spaString = Global.getString(Constant.defaultSpa);
    final spaMap = jsonDecode(spaString);
    final spaData = spa.Data.fromJson(spaMap);

    final response = await addBillAPI(ReqBillCollectAdd(
        fullName: nameCustomer.name,
        idCustomer: nameCustomer.id,
        note: cNote.text,
        id: args?.id,
        idStaff: state.choseStaff.id,
        typeCollectionBill: state.methodPayment.keyValue,
        total: cPrice.text.removeCommaMoney,
        time: state.dateTimeValue.formatDateTime(format: "HH:mm dd/MM/yyyy"),
        idSpa: spaData.id
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
        findController<BillSpendController>().onGetBillSpend(isLoad: false);
      } else {
        errorSnackBar(message: "Không thể lưu phiếu chi");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }
}