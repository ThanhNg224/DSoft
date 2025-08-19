import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/request/req_staff_bonus.dart';
import 'package:spa_project/model/response/model_staff_bonus.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_controller.dart';

class StaffBonusController extends BaseController with Repository {
  StaffBonusController(super.context);

  Widget errorWidget = const SizedBox();
  final staffController = findController<StaffController>();

  @override
  void onInitState() {
    final list = staffController.onTriggerEvent<StaffBloc>().state.listBonus;
    if(list.isEmpty) onGetListBonus();
    super.onInitState();
  }

  void onGetListBonus({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listStaffBonusAPI(ReqStaffBonus(
      page: 1,
      type: "bonus"
    ));
    if(response is Success<ModelStaffBonus>) {
      if(response.value.code == Result.isOk) {
        staffController.onTriggerEvent<StaffBloc>().add(GetBonusStaffEvent(response.value.data ?? []));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelStaffBonus>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }

  }

  void onOpenPayment({String? name, String? phone, int? bonus = 0}) {
    final bloc = onTriggerEvent<StaffBloc>();
    final fName = name == "" || name == null ? "Đang cập nhật" : name;
    final fPhone = phone == "" || phone == null ? "Đang cập nhật" : phone;
    final fBonus = bonus ?? 0;
    popupBottom(child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<StaffBloc, StaffState>(
            builder: (context, state) {
              return SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Thông tin thanh toán", style: TextStyles.def.bold.size(18)),
                      const SizedBox(height: 8),
                      Text("Tên nhân viên: $fName", style: TextStyles.def),
                      const SizedBox(height: 8),
                      Text("Số điện thoại: $fPhone", style: TextStyles.def),
                      const SizedBox(height: 8),
                      Text("Tiền thưởng: ${fBonus.toCurrency(suffix: "đ")}", style: TextStyles.def),
                      const SizedBox(height: 10),
                      WidgetDropDow<ModelPaymentMethod>(
                          title: "Hình thức",
                          topTitle: "Hình thức thanh toán",
                          content: ModelPaymentMethod.listPaymentMethod
                              .map((item) => WidgetDropSpan(value: item))
                              .toList(),
                          validate: state.vaPaymentMethod,
                          getValue: (item) => item.name,
                          value: state.chosePaymentMethod,
                          onSelect: (item) => onTriggerEvent<StaffBloc>().add(SetChosePaymentMethodStaffEvent(item))
                      ),
                      const SizedBox(height: 10),
                      WidgetButton(
                        title: "Thanh toán",
                        onTap: ()=> _onPayment(state),
                      )
                    ],
                  )
              );
            }
        )
    ));
  }

  void _onPayment(StaffState state) async {
    String vaPaymentMethod = state.chosePaymentMethod == null ? "Vui lòng chọn hình thức thanh toán" : "";
    onTriggerEvent<StaffBloc>().add(SetVaPaymentMethodStaffEvent(vaPaymentMethod));
    if(vaPaymentMethod.isEmpty) {
      loadingFullScreen();
      final response = await payBonusAPI(id: args?.model?.id, type: state.chosePaymentMethod?.keyValue);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          pop();
          successSnackBar(message: "Thanh toán thưởng nhân viên ${args?.model?.infoStaff?.name ?? ""} Thành công");
          pop(response.value);
        } else {
          errorSnackBar(message: "Thanh toán thưởng nhân viên ${args?.model?.infoStaff?.name ?? ""} Không thành công");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    }
  }
}