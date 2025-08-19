import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_pay_roll.dart' as list_payroll;
import 'package:spa_project/view/staff/staff_wage/detail/staff_wage_detail_cubit.dart';

class StaffWageDetailController extends BaseController<list_payroll.Data> with Repository {
  StaffWageDetailController(super.context);

  Widget errorWidget = const SizedBox();
  TextEditingController cNote = TextEditingController();
  
  List<ModelSalaryVerifyStatus> listStatusVerify = [
    ModelSalaryVerifyStatus(name: "Chờ duyệt", key: "new"),
    ModelSalaryVerifyStatus(name: "Duyệt", key: "browse"),
    ModelSalaryVerifyStatus(name: "Không duyệt", key: "not_browse"),
    ModelSalaryVerifyStatus(name: "Hủy", key: "cancel"),
  ];

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(args == null) return;
      onTriggerEvent<StaffWageDetailCubit>().setDataStaffWageDetail(args!);
    });
    super.onInitState();
  }

  Widget statusWage(StaffWageDetailState state) {
    String title = "";
    Color color = MyColor.red;

    switch(state.data?.status) {
      case "new":
        title = "Chờ duyệt";
        color = MyColor.slateBlue;
        break;
      case "browse":
        title = "Duyệt";
        color = MyColor.slateGray;
        break;
      case "not_browse":
        title = "Không duyệt";
        color = MyColor.yellow;
        break;
      case "done":
        title = "Đã thanh toán";
        color = MyColor.green;
        break;
      default:
        title = "Hủy";
        color = MyColor.red;
    }

    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color.o3
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          child: Text(title, style: TextStyles.def.semiBold.size(9).colors(color)
          ),
        )
    );
  }

  void onVerification() {
    final bloc = onTriggerEvent<StaffWageDetailCubit>();
    popupConfirm(title: "Phê duyệt", content: BlocProvider.value(
      value: bloc,
      child: BlocBuilder<StaffWageDetailCubit, StaffWageDetailState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              WidgetDropDow<ModelSalaryVerifyStatus>(
                title: "Chọn trạng thái",
                topTitle: "Trạng thái",
                value: state.choseStatus,
                content: listStatusVerify.map((element) => WidgetDropSpan(value: element)).toList(),
                getValue: (value) => value.name,
                onSelect: (value) => onTriggerEvent<StaffWageDetailCubit>().choseStatusStaffWageDetail(value),
              ),
              WidgetInput(
                controller: cNote,
                maxLines: 3,
                title: "Ghi chú",
                hintText: "Nhập ghi chú",
              )
            ],
          );
        }
      ),
    )).confirm(onConfirm: () async {
      loadingFullScreen();
      final response = await salaryVerificationAPI(
        id: args?.id,
        status: onTriggerEvent<StaffWageDetailCubit>().state.choseStatus.key,
        note: cNote.text
      );
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          successSnackBar(message: "Duyệt bảng lương thành công");
          list_payroll.Data newData = list_payroll.Data(
              id: args?.id,
              note: args?.note,
              status: bloc.state.choseStatus.key,
              year: args?.year,
              month: args?.month,
              idStaff: args?.idStaff,
              workingDay: args?.workingDay,
              work: args?.work,
              salary: args?.salary,
              fixedSalary: args?.fixedSalary,
              commission: args?.commission,
              bonus: args?.bonus,
              punish: args?.punish,
              infoStaff: args?.infoStaff,
              createdAt: args?.createdAt,
              advance: args?.advance,
              allowance: args?.allowance,
              fine: args?.fine,
              idMember: args?.idMember,
              insurance: args?.insurance,
              noteBoss: args?.noteBoss,
              paymentDate: args?.paymentDate,
              updatedAt: args?.updatedAt
          );
          onTriggerEvent<StaffWageDetailCubit>().setDataStaffWageDetail(newData);
        } else {
          errorSnackBar(message: "Không thể duyệt bảng lương");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  void onPayment() {
    final bloc = onTriggerEvent<StaffWageDetailCubit>();
    popupConfirm(
      title: "Thanh toán",
      content: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<StaffWageDetailCubit, StaffWageDetailState>(
            builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Thanh toán lương cho nhân viên ${args?.infoStaff?.name}?"),
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
              ],
            );
          }
        ),
      )
    ).confirm(onConfirm: () async {
      loadingFullScreen();
      final response = await salaryPaymentAPI(id: args?.id, type: bloc.state.chosePaymentMethod.keyValue, idSpa: Utilities.getIdSpaDefault);
      hideLoading();
      if(response is Success<int>) {
        if(response.value == Result.isOk) {
          pop(response.value);
          successSnackBar(message: "Thanh toán lương thành công");
        } else {
          errorSnackBar(message: "Không thể thanh toán lương");
        }
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }

  @override
  void onDispose() {
    cNote.dispose();
    super.onDispose();
  }
}

class ModelSalaryVerifyStatus {
  String name;
  String key;
  
  ModelSalaryVerifyStatus({required this.name, required this.key});
}