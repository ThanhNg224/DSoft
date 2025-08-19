import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_order_prepaid_card.dart';
import 'package:spa_project/view/order/order_prepaid_card/order_prepaid_card_controller.dart';
import 'package:spa_project/view/order/order_prepaid_card/order_prepaid_card_cubit.dart';

class OrderPrepaidCardScreen extends BaseView<OrderPrepaidCardController> {
  const OrderPrepaidCardScreen({super.key});

  @override
  OrderPrepaidCardController createController(BuildContext context)
  => OrderPrepaidCardController(context);

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
              Utilities.retryButton(() {}),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return BlocBuilder<OrderPrepaidCardCubit, List<Data>> (
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

                return GestureDetector(
                  // onTap: () => Navigator.pushNamed(context, OrderProductDetailScreen.router, arguments: listOrder[index].id),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: WidgetBoxColor(
                        closed: ClosedEnd.start,
                        closedBot: ClosedEnd.end,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WidgetAvatar(size: 48, url: listOrder[index].infoCustomer?.avatar),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(child: Text(
                                        listOrder[index].infoPrepayCard?.name ?? "",
                                        style: TextStyles.def.bold,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )),
                                      Row(children: [
                                        const Icon(Icons.access_time, size: 14, color: MyColor.hideText),
                                        const SizedBox(width: 4),
                                        Text("${listOrder[index].infoPrepayCard?.useTime ?? 0} ngày",
                                          style: TextStyles.def.colors(MyColor.hideText).size(12),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  const SizedBox(height: 4),

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