import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_product_detail.dart';
import 'package:spa_project/view/order/order_product_detail/order_product_detail_controller.dart';
import 'package:spa_project/view/order/order_product_detail/order_product_detail_cubit.dart';

class OrderProductDetailScreen extends BaseView<OrderProductDetailController> {
  static const String router = "/OrderProductDetailScreen";
  const OrderProductDetailScreen({super.key});

  @override
  OrderProductDetailController createController(BuildContext context)
  => OrderProductDetailController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<OrderProductDetailCubit, ModelOrderProductDetail?>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(title: state?.data?.fullName ?? "Chi tiết đơn sản phẩm"),
          body: _body(state),
        );
      }
    );
  }
  
  Widget _body(ModelOrderProductDetail? state) {
    if(controller.screenStateIsLoading) {
      return SingleChildScrollView(
        physics: Utilities.defaultScroll,
        padding: const EdgeInsets.all(20),
        child: const Column(children: [
          WidgetShimmer(
            height: 400,
            radius: 20,
            width: double.infinity,
          ),
          SizedBox(height: 20),
          WidgetShimmer(
            height: 300,
            radius: 20,
            width: double.infinity,
          ),
        ]),
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              const SizedBox(height: 10),
              Utilities.retryButton(() => controller.onGetDetail()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return WidgetListView(
        children: [
          WidgetBoxColor(
            closed: ClosedEnd.start,
            closedBot: ClosedEnd.end,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetAvatar(
                  size: 120,
                  url: state?.data?.customer?.avatar,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(state?.data?.fullName ?? "", style: TextStyles.def.bold.size(24)),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: ColoredBox(
                    color: MyColor.softWhite,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        _itemInfo(
                            data: state?.data?.customer?.phone,
                            icon: CupertinoIcons.phone_circle,
                            title: "Số điên thoại: "
                        ),
                        _itemInfo(
                            data: state?.data?.customer?.email,
                            icon: CupertinoIcons.mail,
                            title: "Email: "
                        ),
                        _itemInfo(
                            data: state?.data?.time?.formatUnixToHHMMYYHHMM(),
                            icon: CupertinoIcons.clock,
                            title: "Thời gian: "
                        ),
                        _itemInfo(
                            data: "${(state?.data?.total ?? 0).toCurrency()}đ",
                            title: "Chưa giảm giá: "
                        ),
                        _itemInfo(
                            data: "${state?.data?.promotion ?? 0}%",
                            title: "Giảm giá: ",
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(children: [
                  Text("Tổng tiền:", style: TextStyles.def.bold),
                  Expanded(child: Align(
                    alignment: Alignment.centerRight,
                    child: Text("${(state?.data?.totalPay ?? 0).toCurrency()}đ", style: TextStyles.def.bold),
                  ))
                ]),
                const SizedBox(height: 10),
                _widgetStatus(state?.data?.status)
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text("Đơn hàng", style: TextStyles.def.bold.size(18)),
          ),
          WidgetBoxColor(
            closed: ClosedEnd.start,
            closedBot: ClosedEnd.end,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: MyColor.borderInput,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Row(children: [
                      Expanded(flex: 4, child: Text("Sản phẩm", style: TextStyles.def.colors(MyColor.slateGray).bold.size(12))),
                      const SizedBox(width: 10),
                      Expanded(flex: 3, child: Text("Giá bán", style: TextStyles.def.colors(MyColor.slateGray).bold.size(12))),
                    ]),
                  ),
                ),
              ),
              ...List.generate(state?.data?.orderDetail?.length ?? 0, (index) {
                final data = state?.data?.orderDetail?[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [
                    Expanded(flex: 4, child: Text(data?.product?.name ?? "", style: TextStyles.def.colors(MyColor.slateGray).bold.size(12))),
                    const SizedBox(width: 10),
                    Expanded(flex: 3, child: Row(
                      children: [
                        Expanded(
                          child: Text("${(data?.product?.price ?? 0).toCurrency()}đ",
                              style: TextStyles.def.colors(MyColor.slateGray).bold.size(12)),
                        ),
                        Text("+${data?.quantity ?? 0}", style: TextStyles.def.colors(MyColor.slateBlue).bold.size(12))
                      ],
                    )),
                  ]),
                );
              })
            ])
          )
        ]
      );
    }
  }

  Widget _itemInfo({
    IconData? icon,
    String? data,
    required String title,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if(icon != null) Icon(icon, color: MyColor.hideText, size: 20),
      if(icon != null) const SizedBox(width: 6),
      Text(title, style: TextStyles.def.colors(MyColor.hideText)),
      Expanded(child: Align(
        alignment: Alignment.centerRight,
        child: Text(data ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.hideText)))
      )
    ]),
  );

  Widget _widgetStatus(int? status) {
    Color color;
    String statusMes;
    IconData icon;
    switch (status) {
      case 1:
        color = MyColor.green;
        statusMes = "Đã thanh toán";
        icon = Icons.check_circle;
      case 2:
        color = MyColor.red;
        statusMes = "Hủy thanh toán";
        icon = Icons.cancel;
      case 0: default:
        color = MyColor.yellow;
        statusMes = "Chưa thanh toán";
        icon = Icons.warning;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.o2,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Row(children: [
          Icon(icon, color: color),
          const SizedBox(width: 5),
          Text(statusMes, style: TextStyles.def.bold.colors(color))
        ]),
      ),
    );
  }
}