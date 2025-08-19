import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_partner.dart';
import 'package:spa_project/view/product/product_partner/product_partner_cubit.dart';

class ProductPartnerController extends BaseController with Repository {
  ProductPartnerController(super.context);

  Widget errorWidget = const SizedBox();

  @override
  void onInitState() {
    final list = context.read<ProductPartnerCubit>().state;
    if(list.isEmpty) onGetListPartner();
    super.onInitState();
  }

  void onGetListPartner({bool isLoad = true}) async {
    if(isLoad) setScreenState = screenStateLoading;
    final response = await listPartnerAPI(1);
    if(response is Success<ModelListPartner>) {
      if(response.value.code == Result.isOk) {
        onTriggerEvent<ProductPartnerCubit>()
            .getListProductPartnerCubit(response.value.data ?? []);
        setScreenState = screenStateOk;
      } else {
        errorWidget = Utilities.errorMesWidget("Không lấy được nhãn hiệu sản phẩm");
        setScreenState = screenStateError;
      }
    }
    if(response is Failure<ModelListPartner>) {
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
      setScreenState = screenStateError;
    }
  }
}