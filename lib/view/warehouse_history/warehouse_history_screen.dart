import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_warehouse_history.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_controller.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_cubit.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_detail.dart';

class WarehouseHistoryScreen extends BaseView<WarehouseHistoryController> {
  static const String router = "/WarehouseHistoryScreen";
  const WarehouseHistoryScreen({super.key});

  @override
  WarehouseHistoryController createController(BuildContext context)
  => WarehouseHistoryController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: "Lịch sử kho hàng"),
      body: _body()
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              width: double.infinity,
              height: 220,
            ),
          );
        },
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.onGetWarehouseHistory()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    }
    return BlocBuilder<WarehouseHistoryCubit, List<Data>>(
      builder: (context, data) {
        if(data.isEmpty) {
          return WidgetListView(
            onRefresh: () async => controller.onGetWarehouseHistory(),
            children: [Utilities.listEmpty()]
          );
        }
        return WidgetListView.builder(
          onRefresh: () async => controller.onGetWarehouseHistory(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: ()=> Navigator.push(context, CupertinoPageRoute(builder: (context) {
                  return WarehouseHistoryDetail(data: data[index]);
                })),
                child: WidgetBoxColor(
                  closed: ClosedEnd.start,
                  closedBot: ClosedEnd.end,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].warehouse?.name ?? "Đang cập nhật",
                        style: TextStyles.def.bold.size(17),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              width: 5,
                              color: MyColor.slateBlue,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(CupertinoIcons.clock, color: MyColor.hideText, size: 15),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          "${data[index].createdAt?.formatUnixToHHMMYYHHMM()}",
                                          style: TextStyles.def.colors(MyColor.hideText).size(12),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "Nhà cung cấp: ${data[index].parent?.name ?? "Đang cập nhật"}",
                                    style: TextStyles.def,
                                  ),
                                  _infoCount(title: "Số sản phẩm", data: "${data[index].product?.length ?? "0"}"),
                                  _infoCount(title: "Tổng số lượng", data: "${data[index].product?.fold<int>(0, (previousValue, item) => previousValue + item.quantity!.toInt()) ?? 0}"),
                                  _infoCount(title: "Tổng giá nhập", data: controller.priceTotal(data[index].product ?? [])),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
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

  Widget _infoCount({required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(title, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
        Expanded(child: Divider(height: 10, indent: 5, endIndent: 5, color: MyColor.sliver.o3)),
        Text(data, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
      ]),
    );
  }
}