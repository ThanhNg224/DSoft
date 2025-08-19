import 'package:flutter/cupertino.dart';
import 'package:spa_project/model/response/model_warehouse_history.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_controller.dart';

import '../../base_project/package.dart';

class WarehouseHistoryDetail extends StatelessWidget {
  final Data data;

  const WarehouseHistoryDetail({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: "Chi tiết nhập kho hàng"),
      body: WidgetListView(children: [
        Text("Thông tin nhập hàng", style: TextStyles.def.bold.size(18)),
        const SizedBox(height: 10),
        WidgetBoxColor(
            closed: ClosedEnd.start,
            closedBot: ClosedEnd.end,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.warehouse?.name ?? "Đang cập nhật",
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
                                const Icon(CupertinoIcons.clock,
                                    color: MyColor.hideText, size: 15),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "${data.createdAt?.formatUnixToHHMMYYHHMM()}",
                                    style: TextStyles.def
                                        .colors(MyColor.hideText)
                                        .size(12),
                                  ),
                                )
                              ],
                            ),
                            Row(children: [
                              Text(
                                "Nhà cung cấp: ${data.parent?.name}",
                                style: TextStyles.def,
                              ),
                            ]),
                            _infoCount(
                                title: "Số sản phẩm",
                                data: "${data.product?.length ?? "0"}"),
                            _infoCount(
                                title: "Tổng số lượng",
                                data:
                                    "${data.product?.fold<int>(0, (previousValue, item) => previousValue + item.quantity!.toInt()) ?? 0}"),
                            _infoCount(
                                title: "Tổng giá nhập",
                                data: findController<WarehouseHistoryController>().priceTotal(data.product ?? [])),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text("Chi tiết sản phẩm", style: TextStyles.def.bold.size(18)),
        ),
        ...List.generate(data.product?.length ?? 0, (index) {
          final product = data.product?[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Row(children: [
                  Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product?.prod?.name ?? "Đang cập nhật", style: TextStyles.def.bold.size(16)),
                        Text("Đơn giá: ${product?.prod?.price?.toCurrency(suffix: "VND")}", style: TextStyles.def.colors(MyColor.green).bold.size(12))
                      ]
                  )),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Số lượng: ${product?.quantity ?? 0}", style: TextStyles.def.bold.size(16)),
                      Text("Tồn kho: ${product?.prod?.quantity ?? 0}", style: TextStyles.def)
                    ]
                  )),
                ])
            ),
          );
        })
      ]),
    );
  }

  Widget _infoCount({required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(title, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
        Expanded(
            child: Divider(
                height: 10, indent: 5, endIndent: 5, color: MyColor.sliver.o3)),
        Text(data, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
      ]),
    );
  }

}
