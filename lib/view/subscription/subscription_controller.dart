import 'dart:io';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_price_extend.dart';
import 'package:spa_project/model/response/model_pay_extend_member.dart';
import 'package:spa_project/view/subscription/subscription_cubit.dart';

class SubscriptionController extends BaseController with Repository {
  SubscriptionController(super.context);

  Widget errorWidget = const SizedBox();
  final int deadline = Global.getInt(Constant.deadline);
  final int dateNow = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final ServiceSaveImage serviceSaveImage = ServiceSaveImage();

  @override
  void onInitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getPackage());
    super.onInitState();
  }

  void getPackage() {
    Platform.isIOS ? getPackageForIOS() : getPackageForAndroid();
  }

  void getPackageForIOS() async {
    loadingFullScreen();
    setScreenState = screenStateLoading;
    await _initPlatformState();
    try {
      Offerings offerings = await Purchases.getOfferings();
      if (offerings.current != null) {
        List<Package> availablePackages = offerings.current!.availablePackages;
        onTriggerEvent<SubscriptionCubit>().getListPackagesIOS(availablePackages);
      }
      setScreenState = screenStateOk;
      hideLoading();
    } catch (e) {
      setScreenState = screenStateError;
      hideLoading();
      errorWidget = Utilities.errorMesWidget("Đã có lỗi xảy ra, vui lòng thử lại");
      throw ('Error fetch offerings: $e');
    }
  }

  void getPackageForAndroid() async {
    loadingFullScreen();
    setScreenState = screenStateLoading;
    final response = await listpriceExtendAPI();
    hideLoading();
    if(response is Success<List<ModelListPriceExtend>>) {
      setScreenState = screenStateOk;
      onTriggerEvent<SubscriptionCubit>().getListPackagesAndroid(response.value);
    }
    if(response is Failure<List<ModelListPriceExtend>>) {
      setScreenState = screenStateError;
      errorWidget = Utilities.errorCodeWidget(response.errorCode);
    }
  }

  Future<void> _initPlatformState() async {
    PurchasesConfiguration configuration;
    if (Platform.isIOS) {
      configuration = PurchasesConfiguration("appl_DNOfOwCSmZqeNiajLgeMTIxiCqS");
      await Purchases.configure(configuration);
    }
  }

  void onPaymentWithIOS(Package pkg) async {
    try {
      await Purchases.purchasePackage(pkg);
      final customerInfo = await Purchases.getCustomerInfo();
      loadingFullScreen();
      final transactions = customerInfo.nonSubscriptionTransactions;
      if (transactions.isNotEmpty) {
        final latestTransaction = transactions.last;
        final purchaseID = latestTransaction.transactionIdentifier;
        final response = await addMoneyApplePayAPI(purchaseID, latestTransaction.productIdentifier);
        hideLoading();
        if(response is Success<int>) {
          if(response.value == Result.isOk) {
            pop(response.value);
            successSnackBar(message: "Đăng ký thành công");
          } else {
            errorSnackBar(message: "Giao dịch không thành công");
          }
        }
        if(response is Failure<int>) {
          popupConfirm(content: Utilities.errorCodeWidget(response.errorCode));
        }
      } else {
        errorSnackBar(message: "Không có giao dịch nào.");
      }
    } catch (e) {
      errorSnackBar(message: "Đăng ký không thành công");
    }
  }

  void onPaymentWithAndroid(int? yer, int? price) {
    popupBottom(child: _contentPopupForAndroid(yer, price,
      onPayment: () async {
        loadingFullScreen();
        final response = await payExtendMemberAPI(yer);
        hideLoading();
        if(response is Success<ModelPayExtendMember>) {
          if(response.value.code == Result.isOk) {
            final data = response.value.data;
            popupBottom(child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  WidgetImage(
                    imageUrl: data?.linkQR,
                    loadingImage: const WidgetLoading(),
                  ),
                  SizedBox(
                    width: 200,
                    child: WidgetButton(
                      title: "Lưu về thiết bị",
                      iconLeading: Icons.file_download_outlined,
                      color: MyColor.red,
                      vertical: 7,
                      onTap: ()=> onSaveImage(data?.linkQR),
                    ),
                  )
                ],
              ),
            ));
          } else {
            popupConfirm(
              content: Utilities.errorMesWidget("Không thể thực hiện thanh toán")
            ).normal();
          }
        }
        if(response is Failure<ModelPayExtendMember>) {
          popupConfirm(
            content: Utilities.errorCodeWidget(response.errorCode)
          ).normal();
        }
      },
    ));
  }

  void onSaveImage(String? url) async {
    loadingFullScreen();
    final result = await serviceSaveImage.saveImageGallery(url);
    hideLoading();
    if(!context.mounted) return;
    if(result.notPermission) {
      popupConfirm(content: Text(result.message ?? "",
        style: TextStyles.def,
        textAlign: TextAlign.center,
      )).confirm(onConfirm: () => openAppSettings());
    }
    if(result.isSuccess) {
      Utilities.openToast(context, result.message ?? "");
    } else {
      popupConfirm(content: Text(result.message ?? "",
        style: TextStyles.def,
        textAlign: TextAlign.center,
      )).normal();
    }
  }

  Widget _contentPopupForAndroid(int? yer, int? price, {required Function() onPayment}) {
    return SizedBox(
      width: double.infinity,
      child: Column(children: [
        Container(
          width: 50,
          height: 5,
          margin: const EdgeInsets.only(bottom: 7),
          decoration: BoxDecoration(
              color: MyColor.hideText,
              borderRadius: BorderRadiusDirectional.circular(100)
          ),
        ),
        Row(children: [
          Expanded(child: Text("Gia hạn tài khoản", style: TextStyles.def.bold.size(18))),
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: ClipOval(
              child: ColoredBox(
                color: MyColor.darkNavy.o2,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close, color: MyColor.darkNavy),
                ),
              ),
            ),
          )
        ]),
        const SizedBox(height: 10),
        DecoratedBox(
          decoration: BoxDecoration(
            color: MyColor.softWhite,
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  child: Image.asset("assets/icon_app.png", height: 50, width: 50)
                ),
                const SizedBox(width: 10),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$yer năm sử dụng ứng dụng DSOFT", style: TextStyles.def.bold),
                    Text("DSOFT - Quản lý SPA, SALON, gia hạn gói $yer năm", style: TextStyles.def.colors(MyColor.slateGray)),
                  ],
                ))
              ]),
              const Divider(color: MyColor.borderInput),
              Text("Giá: ${price?.toCurrency()}đ", style: TextStyles.def.bold.size(18)),
              Text("Phí gia hạn hằng năm", style: TextStyles.def.colors(MyColor.slateGray)),
              const Divider(color: MyColor.borderInput),
              Text("Tiếp tục sử dụng ứng dụng với đầy đủ tính năng trong 1 năm kể từ ngày gia hạn.", style: TextStyles.def),
              const Divider(color: MyColor.borderInput),
              Text("Hình thức thanh toán: Quét mã", style: TextStyles.def.colors(MyColor.slateGray))
            ]),
          ),
        ),
        const SizedBox(height: 10),
        WidgetButton(
          title: "Tiếp tục",
          radius: 100,
          onTap: () {
            Navigator.pop(context);
            onPayment();
          },
        )
      ]),
    );
  }

}


