import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/request/req_add_debt_collection.dart';
import 'package:spa_project/model/request/req_get_list_staff.dart';
import 'package:spa_project/model/request/req_payment_collection.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/debt_management/debt_add_collection/debt_add_collection_cubit.dart';
import 'package:spa_project/view/debt_management/debt_collection/debt_collection_controller.dart';
import 'package:spa_project/view/debt_management/debt_management_screen.dart';
import 'package:spa_project/view/debt_management/debt_paid/debt_paid_controller.dart';

class DebtAddCollectionController extends BaseController<DebtManagementSend> with Repository {
  DebtAddCollectionController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cName = TextEditingController();
  TextEditingController cPrice = TextEditingController();
  TextEditingController cNote = TextEditingController();
  TextEditingController cPricePayment = TextEditingController();
  TextEditingController cNotePay = TextEditingController();
  final ServiceDateTimePicker dateTimePicker = ServiceDateTimePicker();

  late bool isInfoViewCollectionDebt;
  late bool isInfoViewPaidDebt;
  late bool isViewPaidDebt;

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onGetListStaff();

      isInfoViewCollectionDebt = args?.isCollectionDebt == true && args?.data != null;
      isInfoViewPaidDebt = args?.isCollectionDebt == false && args?.data != null;
      isViewPaidDebt = args?.isCollectionDebt == false && args?.data == null;

      if(isViewPaidDebt) {
        onTriggerEvent<DebtAddCollectionCubit>().setTitleAppDebtAddCollection(
            title: "Tạo công nợ phải trả",
            titleButton: "Tạo công nợ"
        );
      }
      if(args?.data == null) return;

      cName.text = args?.data?.fullName ?? "";
      cPrice.text = args?.data?.total?.toCurrency() ?? "";
      cNote.text = args?.data?.note ?? "";
      onTriggerEvent<DebtAddCollectionCubit>().setDateTimeDebtAddCollection(
          args?.data?.time != null
              ? DateTime.fromMillisecondsSinceEpoch(args!.data!.time! * 1000)
              : DateTime.now()
      );
      onTriggerEvent<DebtAddCollectionCubit>().setChoseStaffDebtAddCollection(
        Data(name: args?.data?.staff?.name, id: args?.data?.staff?.id)
      );
      if(isInfoViewCollectionDebt) {
        onTriggerEvent<DebtAddCollectionCubit>().setTitleAppDebtAddCollection(
          title: "Thông tin công nợ phải thu",
          titleButton: "Sửa công nợ"
        );
      } else if(isInfoViewPaidDebt) {
        onTriggerEvent<DebtAddCollectionCubit>().setTitleAppDebtAddCollection(
          title: "Thông tin công nợ phải trả",
          titleButton: "Sửa công nợ"
        );
      }
    });
    super.onInitState();
  }

  void onGetListStaff() async {
    loadingFullScreen();
    final response = await listStaffAPI(ReqGetListStaff(page: 1));
    hideLoading();
    if(response is Success<ModelListStaff>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<DebtAddCollectionCubit>().getListStaffDebtAddCollection(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListStaff>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
  
  void onChoseDate() async {
    final date = await dateTimePicker.open(context, initTime: onTriggerEvent<DebtAddCollectionCubit>().state.dateTimeValue);
    onTriggerEvent<DebtAddCollectionCubit>().setDateTimeDebtAddCollection(date);
  }

  bool _isValidate(DebtAddCollectionState state) {
    String vaName = cName.text.isEmpty ? "Vui lòng nhập tên nhân viên" : "";
    String vaPrice = cPrice.text.isEmpty ? "Vui lòng nhập số tiền nợ" : "";
    String vaStaff = "";
    onTriggerEvent<DebtAddCollectionCubit>().setVaNameDebtAddCollection(
      vaName: vaName,
      vaPrice: vaPrice,
      vaStaff: vaStaff
    );
    return vaName.isEmpty && vaPrice.isEmpty && vaStaff.isEmpty;
  }

  ReqAddDebtCollection _requestAdd(DebtAddCollectionState state) {
    return ReqAddDebtCollection(
      note: cNote.text,
      fullName: cName.text,
      idCustomer: state.choseStaff.id,
      time: state.dateTimeValue.formatDateTime(),
      total: cPrice.text.removeCommaMoney,
      id: args?.data?.id
    );
  }

  void onCreateDebt(DebtAddCollectionState state) async {
    if(!_isValidate(state)) return warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    loadingFullScreen();
    final response = args?.isCollectionDebt == true ? await addCollectionDebtAPI(_requestAdd(state)) : await addPayableDebtAPI(_requestAdd(state));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
        if(args?.isCollectionDebt == true) {
          findController<DebtCollectionController>().onGetDebtCollection(isLoad: false);
        } else {
          findController<DebtPaidController>().onGetListPaid(isLoad: false);
        }
      } else {
        errorSnackBar(message: "Không thể thêm được dữ liệu");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  ReqPaymentCollection _requestPayment(DebtAddCollectionState state) => ReqPaymentCollection(
    id: args?.data?.id,
    total: cPricePayment.text.removeCommaMoney,
    typeCollectionBill: state.chosePaymentMethod.keyValue,
    note: cNotePay.text
  );

  void onPayment() async {
    final bloc = onTriggerEvent<DebtAddCollectionCubit>();
    popup(
      content: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<DebtAddCollectionCubit, DebtAddCollectionState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetDropDow<ModelPaymentMethod>(
                  title: "Hình thức",
                  topTitle: "Hình thức thanh toán",
                  content: ModelPaymentMethod.listPaymentMethod
                      .map((item) => WidgetDropSpan(value: item))
                      .toList(),
                  getValue: (item) => item.name,
                  value: state.chosePaymentMethod,
                  onSelect: (item) => bloc.setChosePaymentMethod(item)
                ),
                WidgetInput(
                  title: "Giá tiền",
                  hintText: "Nhập giá tiền trả",
                  controller: cPricePayment,
                  validateValue: state.vaPricePay,
                  keyboardType: TextInputType.number,
                  inputFormatters: [AutoFormatInput()],
                ),
                WidgetInput(
                  maxLines: 3,
                  title: "Nội dung thanh toán",
                  hintText: "Nhập nội dung thanh toán",
                  controller: cNotePay,
                )
              ],
            );
          }
        ),
      ),
      title: "Thanh toán công nợ",
      bottom: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: WidgetButton(
          title: "Thanh toán",
          vertical: 8,
          onTap: () async {
            final state = onTriggerEvent<DebtAddCollectionCubit>().state;
            String vaPrice = cPricePayment.text.isEmpty ? "Vui lòng nhập số tiền thanh toán" : "";
            onTriggerEvent<DebtAddCollectionCubit>().setVaNameDebtAddCollection(vaPricePay: vaPrice);
            if(vaPrice.isNotEmpty) return;
            loadingFullScreen();
            final response = args?.isCollectionDebt == true
                ? await paymentCollectionBillAPI(_requestPayment(state))
                : await paymentBillAPI(_requestPayment(state));
            hideLoading();
            if(response is Success<int>) {
              if(response.value == Result.isOk) {
                pop();
                pop(response.value);
                args?.isCollectionDebt == true
                  ? findController<DebtCollectionController>().onGetDebtCollection(isLoad: false)
                  : findController<DebtPaidController>().onGetListPaid(isLoad: false);
              } else {
                errorSnackBar(message: "Đã có lỗi xảy ra, không thể thực hiện thanh toán");
              }
            }
            if(response is Failure<int>) {
              popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
            }
          },
        ),
      )
    );
  }
  
  @override
  void onDispose() {
    cName.dispose();
    cPrice.dispose();
    cNote.dispose();
    cPricePayment.dispose();
    cNotePay.dispose();
    super.onDispose();
  }
}