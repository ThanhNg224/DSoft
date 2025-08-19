import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/request/req_add_prepaid_card.dart';
import 'package:spa_project/model/response/model_prepaid_card.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_add/prepaid_card_add_cubit.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_controller.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_cubit.dart';

class PrepaidCardAddController extends BaseController<Data> with Repository {
  PrepaidCardAddController(super.context);

  TextEditingController cPrice = TextEditingController();
  TextEditingController cFaceValue = TextEditingController();
  TextEditingController cUseTime = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController cNote = TextEditingController();
  TextEditingController cPriceForStaff = TextEditingController();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(args == null) return;
      cPrice.text = args?.price?.toCurrency() ?? '';
      cName.text = args?.name ?? '';
      cFaceValue.text = args?.priceSell?.toCurrency() ?? '';
      cUseTime.text = args?.useTime.toString() ?? '';
      cNote.text = args?.note ?? '';
      cPriceForStaff.text = args?.commissionStaffFix?.toCurrency() ?? '';
      onTriggerEvent<PrepaidCardAddCubit>().changePercent(args?.commissionStaffPercent ?? 0);
      onTriggerEvent<PrepaidCardAddCubit>().changeTitle("Sửa thẻ trả trước");
    });
    super.onInitState();
  }

  @override
  void onDispose() {
    cPrice.dispose();
    cFaceValue.dispose();
    cUseTime.dispose();
    cName.dispose();
    cNote.dispose();
    cPriceForStaff.dispose();
    super.onDispose();
  }

  bool _isValidate() {
    String vaPrice = cPrice.text.isEmpty ? "Vui lòng nhập giá" : "" ;
    String vaName = cPrice.text.isEmpty ? "Vui lòng nhập tên thẻ" : "";
    String vaFaceValue = cPrice.text.isEmpty ? "Vui lòng nhập mệnh giá" : "";
    context.read<PrepaidCardAddCubit>().setValidatePrepaidCardAdd(
      vaPrice: vaPrice,
      vaName: vaName,
      vaFaceValue: vaFaceValue,
    );
    return vaPrice.isEmpty && vaName.isEmpty && vaFaceValue.isEmpty;
  }

  void onAddEditPrepaidCard(PrepaidCardAddState state) async {
    if(!_isValidate()) return warningSnackBar(message: "Vui lòng kiểm tra lại thông tin");
    loadingFullScreen();
    final response = await addPrepayCardAPI(ReqAddPrepaidCard(
      name: cName.text,
      note: cNote.text,
      id: args?.id,
      commissionStaffPercent: state.commissionStaffPercent,
      status: state.status,
      commissionStaffFix: cPriceForStaff.text.removeCommaMoney,
      priceSell: cFaceValue.text.removeCommaMoney,
      useTime: cUseTime.text.removeCommaMoney,
      price: cPrice.text.removeCommaMoney
    ));
    hideLoading();
    if(response is Success<int>) {
      if(response.value == Result.isOk) {
        pop(response.value);
      } else {
        errorSnackBar(message: "Thêm thẻ thất bại");
      }
    }
    if(response is Failure<int>) {
      popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
    }
  }

  void onDeletePrepaid() {
    popupConfirm(content: Text("Bạn có chắc chắn xóa ${args?.name ?? "thẻ trả trước không"}")).serious(onTap: () async {
      loadingFullScreen();
      final response = await deletePrepayCardAPI(args?.id);
      hideLoading();
      if(response is Success<int>) {
        final remote = findController<PrepaidCardController>();
        final index = remote.onTriggerEvent<PrepaidCardCubit>().state.indexWhere((element) => element.id == args?.id);
        List<Data> currentList = List.from(remote.onTriggerEvent<PrepaidCardCubit>().state);
        currentList.removeAt(index);
        remote.onTriggerEvent<PrepaidCardCubit>().getListPrepaidCard(currentList);
        pop();
      }
      if(response is Failure<int>) {
        popupConfirm(content: Utilities.errorCodeWidget(response.errorCode)).normal();
      }
    });
  }
}