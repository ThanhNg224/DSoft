import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_pay_roll.dart';
import 'package:spa_project/model/response/model_list_pay_roll.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_wage/detail/staff_wage_detail_screen.dart';

class StaffWageController extends BaseController with Repository {
  StaffWageController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    onGetListPayRoll();
    super.onInitState();
  }

  void onGetListPayRoll({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listPayrollAPI(ReqPayRoll());
    if(response is Success<ModelListPayRoll>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<StaffBloc>().add(GetListPayRollStaffEvent(response.value.data ?? []));
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không thể lấy được danh sách bảng lương");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListPayRoll>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }

  Widget statusWage(StaffState state, int index) {
    String title = "";
    Color color = MyColor.red;
    final status = state.listPayroll[index].status;

    switch(status) {
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

  void toDetailStaffWage(Data data) {
    pushName(StaffWageDetailScreen.router, args: data).then((value) {
      if(value == Result.isOk) onGetListPayRoll(isLoad: false);
    });
  }

}