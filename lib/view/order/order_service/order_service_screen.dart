import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_service.dart';
import 'package:spa_project/view/order/order_service/order_service_controller.dart';
import 'package:spa_project/view/order/order_service/order_service_cubit.dart';
import 'package:spa_project/view/order/order_service_detail/order_service_detail_screen.dart';

class OrderServiceScreen extends BaseView<OrderServiceController> {
  const OrderServiceScreen({super.key});

  @override
  OrderServiceController createController(BuildContext context)
  => OrderServiceController(context);

  @override
  Widget zBuild() {
    return ColoredBox(
      color: MyColor.softWhite,
      child: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              radius: 20,
              height: 130,
              width: double.infinity,
            ),
          );
        },
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
              Utilities.retryButton(() => controller.onGetListOrderService()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return BlocBuilder<OrderServiceCubit, List<Data>>(
          builder: (context, listOrder) {
            if(listOrder.isEmpty) {
              return WidgetListView(
                onRefresh: () async => controller.onRefresh(),
                padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
                children: [Utilities.listEmpty()]
              );
            }
            return WidgetListView.builder(
              itemCount: listOrder.length + (controller.isMoreEnable ? 1 : 0),
              controller: controller.scrollController,
              onRefresh: () async => controller.onRefresh(),
              itemBuilder: (context, index) {
                if (index >= listOrder.length) return const WidgetLoading();
                final listOrderDetail = listOrder[index].orderDetail ?? [];
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, OrderServiceDetailScreen.router, arguments: listOrder[index].id),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: WidgetBoxColor(
                        closed: ClosedEnd.start,
                        closedBot: ClosedEnd.end,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WidgetAvatar(size: 48, url: listOrder[index].customer?.avatar),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(
                                        listOrder[index].fullName == "" || listOrder[index].fullName == null
                                            ? "Không có thông tin"
                                            : listOrder[index].fullName ?? "Đang cập nhật",
                                        style: TextStyles.def.bold,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                      Row(children: [
                                        const Icon(Icons.access_time, size: 14, color: MyColor.hideText),
                                        const SizedBox(width: 4),
                                        Text((listOrder[index].time ?? 0).formatUnixToHHMMYYHHMM(),
                                          style: TextStyles.def.colors(MyColor.hideText).size(12),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ColoredBox(
                                        color: MyColor.softWhite,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(
                                                listOrderDetail.length > 3 ? 3 : listOrderDetail.length,
                                                    (index) => Row(
                                                  children: [
                                                    Expanded(child: Text(
                                                      listOrderDetail[index].service?.name ?? "Sản phẩm khác",
                                                      style: TextStyles.def.colors(MyColor.hideText),
                                                    )),
                                                    Text("× ${listOrderDetail[index].quantity ?? 0}",
                                                        style: TextStyles.def.bold.colors(MyColor.slateBlue)
                                                    )
                                                  ],
                                                ),
                                              ),
                                              if (listOrderDetail.length > 3)
                                                Text(
                                                  "+${listOrderDetail.length - 3} sản phẩm khác",
                                                  style: TextStyles.def.colors(MyColor.hideText).bold,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(children: [
                                    Text("Tổng tiền: ", style: TextStyles.def.size(13)),
                                    const SizedBox(width: 5),
                                    Text("${(listOrder[index].total ?? 0).toCurrency()}đ", style: TextStyles.def.colors(MyColor.green).size(13).bold)
                                  ]),
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                  ),
                );
              },
            );
          }
      );
    }
  }

}