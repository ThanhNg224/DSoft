import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_combo.dart';
import 'package:spa_project/view/combo_treatment/combo_treatment_controller.dart';
import 'package:spa_project/view/combo_treatment/combo_treatment_cubit.dart';

class ComboTreatmentScreen extends BaseView<ComboTreatmentController> {
  static const String router = '/ComboTreatmentScreen';
  const ComboTreatmentScreen({super.key});

  @override
  ComboTreatmentController createController(BuildContext context)
  => ComboTreatmentController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: WidgetAppBar(
        title: "Combo liệu trình",
        actionIcon: WidgetButton(
          iconLeading: Icons.add,
          vertical: 0,
          horizontal: 10,
          onTap: () => controller.toAddEdit(),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(height: 170),
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
                Utilities.retryButton(() => controller.onGetListCombo()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<ComboTreatmentCubit, List<Data>>(
        builder: (context, data) {
          if(data.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.onGetListCombo(),
              children: [Utilities.listEmpty()],
            );
          }
          return WidgetListView.builder(
            onRefresh: () async => controller.onRefresh(),
            itemCount: data.length + (controller.isMoreEnable ? 1 : 0),
            controller: controller.scrollController,
            itemBuilder: (context, index) {
              if (index >= data.length) return const WidgetLoading();
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: GestureDetector(
                  onTap: ()=> controller.toAddEdit(data: data[index]),
                  child: WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index].name ?? "Đang cập nhật",
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
                                            child: Text(controller.remainingDays(data, index),
                                              style: TextStyles.def.colors(MyColor.hideText).size(12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      _infoCount(title: "Số lượng", data: "${data[index].quantity ?? 0}"),
                                      _infoCount(title: "Trạng thái", data: data[index].status == "active" ? "Kích hoạt" : "Khóa"),
                                      _infoCount(title: "Giá bán", data: (data[index].price ?? 0).toCurrency(suffix: "đ")),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                          IntrinsicHeight(
                            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            if((data[index].listProduct??[]).isNotEmpty) Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ColoredBox(
                                    color: MyColor.borderInput,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Sản phẩm", style: TextStyles.def.bold),
                                          ...List.generate(data[index].listProduct?.length ?? 0, (indexProduct) {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Text(data[index].listProduct?[indexProduct].name ?? "",
                                                    style: TextStyles.def.size(12).colors(MyColor.slateGray),
                                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                const SizedBox(width: 5),
                                                Text("x${data[index].listProduct?[indexProduct].quantityCombo ?? 0}",
                                                  style: TextStyles.def.size(12).colors(MyColor.slateGray),
                                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            );
                                          })
                                        ]
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if((data[index].listProduct??[]).isNotEmpty
                                  && (data[index].listService??[]).isNotEmpty
                              ) const SizedBox(width: 5),
                              if((data[index].listService??[]).isNotEmpty) Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ColoredBox(
                                    color: MyColor.borderInput,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Dịch vụ", style: TextStyles.def.bold),
                                            ...List.generate(data[index].listService?.length ?? 0, (indexSer) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(data[index].listService?[indexSer].name ?? "",
                                                      style: TextStyles.def.size(12).colors(MyColor.slateGray),
                                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text("x${data[index].listService?[indexSer].quantityCombo ?? 0}",
                                                    style: TextStyles.def.size(12).colors(MyColor.slateGray),
                                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              );
                                            })
                                          ]
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          )
                        ],
                      )
                  ),
                ),
              );
            },
          );
        },
      );
    }
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