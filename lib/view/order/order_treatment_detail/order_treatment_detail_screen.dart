import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/order/order_treatment_detail/order_treatment_detail_controller.dart';
import 'package:spa_project/view/order/order_treatment_detail/order_treatment_detail_cubit.dart';

class OrderTreatmentDetailScreen extends BaseView<OrderTreatmentDetailController> {
  static const String router = "/OrderTreatmentDetailScreen";
  const OrderTreatmentDetailScreen({super.key});

  @override
  OrderTreatmentDetailController createController(BuildContext context)
  => OrderTreatmentDetailController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: "Thông tin đơn liệu trình"),
      body: _body,
    );
  }

  Widget get _body {
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
      return BlocBuilder<OrderTreatmentDetailCubit, OrderTreatmentDetailState>(
        builder: (context, state) {
          final dataOrder = state.detail.data?.orderDetail ?? [];

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
                        url: state.detail.data?.customer?.avatar,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(state.detail.data?.fullName ?? "", style: TextStyles.def.bold.size(24), textAlign: TextAlign.center),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ColoredBox(
                          color: MyColor.softWhite,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(children: [
                              _itemInfo(
                                  data: state.detail.data?.customer?.phone,
                                  icon: CupertinoIcons.phone_circle,
                                  title: "Số điên thoại: "
                              ),
                              _itemInfo(
                                  data: state.detail.data?.customer?.email,
                                  icon: CupertinoIcons.mail,
                                  title: "Email: "
                              ),
                              _itemInfo(
                                  data: state.detail.data?.time?.formatUnixToHHMMYYHHMM(),
                                  icon: CupertinoIcons.clock,
                                  title: "Thời gian: "
                              ),
                              _itemInfo(
                                  data: "${(state.detail.data?.total ?? 0).toCurrency()}đ",
                                  title: "Chưa giảm giá: "
                              ),
                              _itemInfo(
                                data: "${state.detail.data?.promotion ?? 0}%",
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
                          child: Text("${(state.detail.data?.totalPay ?? 0).toCurrency()}đ", style: TextStyles.def.bold),
                        ))
                      ]),
                      const SizedBox(height: 10),
                      _widgetStatus(state.detail.data?.status)
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text("Đơn hàng", style: TextStyles.def.bold.size(18)),
              ),
              ...List.generate(dataOrder.length, (indexDetail) {
                final combo = dataOrder[indexDetail].combo;
                final comboProducts = combo?.comboProduct ?? [];
                final comboServices = combo?.comboService ?? [];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: MyColor.borderInput,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Combo: ${combo?.name ?? ""}", style: TextStyles.def.bold),
                                    Text("Giá: ${dataOrder[indexDetail].price?.toCurrency(suffix: "đ")}", style: TextStyles.def.colors(MyColor.slateGray)),
                                  ],
                                )),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ColoredBox(
                                    color: MyColor.slateBlue,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text("x${dataOrder[indexDetail].quantity}", style: TextStyles.def.bold.colors(MyColor.white).size(12)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (comboProducts.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Sản phẩm trong combo:", style: TextStyles.def.bold.colors(MyColor.slateGray)),
                          ),
                          ...comboProducts.map((product) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.name ?? "", style: TextStyles.def.bold),
                                  Text("SL: ${product.quantityCombo} - Giá: ${(product.price ?? 0).toCurrency()}đ", style: TextStyles.def.colors(MyColor.slateGray)),
                                ],
                              ),
                              const Divider()
                            ],
                          ))
                        ],
                        if (comboServices.isNotEmpty) ...[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Dịch vụ trong combo:", style: TextStyles.def.bold.colors(MyColor.slateGray)),
                          ),
                          ...comboServices.map((service) => Column(
                            children: [
                              Row(children: [
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(service.name ?? "", style: TextStyles.def.bold),
                                    Text("Sử dụng: ${service.quantityComboUse}/${service.quantityCombo} - Giá: ${(service.price ?? 0).toCurrency(suffix: "đ")}", style: TextStyles.def.colors(MyColor.slateGray)),
                                  ]
                                )),
                                if((service.quantityComboUse ?? 0) < (service.quantityCombo ?? 0)) WidgetButton(
                                  title: "Sử dụng",
                                  vertical: 3,
                                  horizontal: 10,
                                  styleTitle: TextStyles.def.bold.colors(MyColor.white),
                                  onTap: ()=> controller.onUseService(service.id),
                                ) else Text("Đã dùng hết lượt", style: TextStyles.def.size(12).colors(MyColor.slateGray))
                              ]),
                              const Divider()
                            ],
                          ))
                        ]
                      ],
                    ),
                  ),
                );
              })

            ],
          );
        }
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