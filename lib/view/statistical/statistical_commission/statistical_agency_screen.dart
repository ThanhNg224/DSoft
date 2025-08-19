import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/statistical/statistical_commission/statistical_agency_controller.dart';

import '../statistical_cubit.dart';

class StatisticalAgencyScreen extends BaseView<StatisticalAgencyController> {
  const StatisticalAgencyScreen({super.key});

  @override
  StatisticalAgencyController createController(BuildContext context)
  => StatisticalAgencyController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: WidgetShimmer(
          width: double.infinity,
          height: Utilities.screen(context).h / 2,
        ),
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              Utilities.retryButton(() => controller.onGetListAgency())
            ],
          ),
        )),
      );
    } else {
      return BlocBuilder<StatisticalCubit, StatisticalState>(
        builder: (context, state) {
          if(state.listAgency.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.onGetListAgency(isLoad: false),
              children: [Utilities.listEmpty()]
            );
          } else {
            return WidgetListView.builder(
              onRefresh: () async => controller.onGetListAgency(isLoad: false),
              itemCount: state.listAgency.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    onTap: () => controller.onOpenPayment(state: state, index: index),
                    child: WidgetBoxColor(
                        closed: ClosedEnd.start,
                        closedBot: ClosedEnd.end,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.listAgency[index].staff?.name ?? "Đang cập nhật",
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
                                                "${state.listAgency[index].order?.time?.formatUnixToHHMMYYHHMM()}",
                                                style: TextStyles.def.colors(MyColor.hideText).size(12),
                                              ),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Khách hàng: ${state.listAgency[index].order?.customer?.name} "
                                              "- ${state.listAgency[index].order?.customer?.phone}",
                                          style: TextStyles.def,
                                        ),
                                        _infoCount(title: "Hoa hồng", data: "${state.listAgency[index].money?.toCurrency(suffix: "đ")}"),
                                        _infoCount(title: "Dịch vụ", data: state.listAgency[index].service ?? "Đang cập nhật"),
                                        _infoCount(title: "Trạng thái", data: state.listAgency[index].status == 0 ? "Chưa thanh toán" : "Thanh toán"),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  )
                );
              },
            );
          }
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