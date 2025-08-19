import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/request/req_agency.dart';
import 'package:spa_project/model/response/model_list_agency.dart';
import 'package:spa_project/view/statistical/statistical_controller.dart';
import 'package:spa_project/view/statistical/statistical_cubit.dart';

class StatisticalAgencyController extends BaseController with Repository {
  StatisticalAgencyController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cNote = TextEditingController();

  @override
  void onInitState() {
    final list = findController<StatisticalController>()
        .onTriggerEvent<StatisticalCubit>().state.listAgency;
    if(list.isEmpty) onGetListAgency();
    super.onInitState();
  }

  void onGetListAgency({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listAgencyAPI(ReqAgency(
      page: 1
    ));
    if(response is Success<ModelListAgency>) {
      if(response.value.code == Result.isOk) {
        setScreenState = screenStateOk;
        findController<StatisticalController>()
            .onTriggerEvent<StatisticalCubit>()
            .getAgencyEvent(response.value.data ?? []);
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được dữ liệu");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListAgency>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  void onOpenPayment({required StatisticalState state, required int index}) {
    final bloc = onTriggerEvent<StatisticalCubit>();
    cNote.clear();
    popup(
      content: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<StatisticalCubit, StatisticalState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tên người tiếp thị: ${state.listAgency[index].staff?.name ?? ""}", style: TextStyles.def
                        .semiBold
                        .colors(MyColor.slateGray)),
                    const SizedBox(height: 6),
                    Text("Số điện thoại: ${state.listAgency[index].staff?.phone ?? ""}", style: TextStyles.def
                        .semiBold
                        .colors(MyColor.slateGray)),
                    const SizedBox(height: 6),
                    Text("Số tiền thanh thoán: ${state.listAgency[index].money?.toCurrency(suffix: "đ") ?? ""}", style: TextStyles.def
                        .semiBold
                        .colors(MyColor.slateGray)),
                    const SizedBox(height: 6),
                    WidgetDropDow<ModelPaymentMethod>(
                      title: "Hình thức",
                      topTitle: "Hình thức thanh toán",
                      content: ModelPaymentMethod.listPaymentMethod
                          .map((item) => WidgetDropSpan(value: item))
                          .toList(),
                      validate: state.vaType,
                      getValue: (item) => item.name,
                      value: state.chosePaymentMethod,
                      onSelect: (item) {
                        onTriggerEvent<StatisticalCubit>().setVaTypeEvent("");
                        onTriggerEvent<StatisticalCubit>().setPaymentMethodEvent(item);
                      },
                    ),
                    WidgetInput(
                      controller: cNote,
                      title: "Nội dung thanh toán",
                      hintText: "Nhập nội dung thanh toán",
                      maxLines: 3,
                    ),
                  ],
                ),
              );
            }
        ),
      ),
      bottom: WidgetButton(
        title: "Thanh toán",
        vertical: 7,
        onTap: () => _onPayment(state, index),
      )
    );
  }

  void _onPayment(StatisticalState state, int index) async {
    if(state.chosePaymentMethod == null) {
      onTriggerEvent<StatisticalCubit>().setVaTypeEvent("Vui lòng chọn hình thức thanh toán");
      return;
    }
    loadingFullScreen();
    final response = await payAgencyAPI(id: state.listAgency[index].id, type: state.chosePaymentMethod?.keyValue);
    hideLoading();
    pop();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        onGetListAgency(isLoad: false);
        successSnackBar(message: "Thanh toán hoa hồng cho nhân viên ${state.listAgency[index].staff?.name ?? ""}");
      } else {
        errorSnackBar(message: "Không thể thanh toán");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  @override
  void onDispose() {
    cNote.dispose();
    super.onDispose();
  }
}