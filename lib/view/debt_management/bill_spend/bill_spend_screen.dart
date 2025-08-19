import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/view/debt_management/bill_spend/bill_spend_controller.dart';
import 'package:spa_project/view/debt_management/bill_spend_add/bill_spend_add_screen.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';

class BillSpendScreen extends BaseView<BillSpendController> {
  final DebtManagementState state;
  const BillSpendScreen({super.key, required this.state});

  @override
  BillSpendController createController(BuildContext context)
  => BillSpendController(context);

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
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              height: 180,
              width: double.infinity,
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
                Utilities.retryButton(() => controller.onGetBillSpend()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      if(state.listSpendBill.isEmpty) {
        return WidgetListView(
          onRefresh: () async => controller.onGetBillSpend(),
          children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView.builder(
        itemCount: state.listSpendBill.length,
        onRefresh: () async => controller.onGetBillSpend(isLoad: false),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {

          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: ()=> Navigator.pushNamed(context, BillSpendAddScreen.router, arguments: state.listSpendBill[index]),
              child: WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(child: Text(state.listSpendBill[index].fullName ?? "Đang cập nhật", style: TextStyles.def.bold)),
                          const Icon(CupertinoIcons.clock, color: MyColor.hideText, size: 15),
                          const SizedBox(width: 5),
                          Text(state.listSpendBill[index].time?.formatUnixTimeToDateDDMMYYYY() ?? "Đang cập nhật",
                            style: TextStyles.def.size(12).bold.colors(MyColor.hideText),
                          )
                        ]),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                width: 5,
                                child: ColoredBox(color: MyColor.slateBlue),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoCount(title: "Người nộp:", data: state.listSpendBill[index].fullName ?? "Đang cập nhật"),
                                    _infoCount(title: "Người thu:", data: state.listSpendBill[index].staff?.name ?? "Đang cập nhật"),
                                    _infoCount(title: "Số tiền:", data: "${state.listSpendBill[index].total?.toCurrency(suffix: "đ")}, "
                                        "${ModelPaymentMethod.getNameByKey(state.listSpendBill[index].typeCollectionBill)}"),
                                    // _infoCount(title: "Trạng thái:", data: state[index].status == "active" ? "Hoạt động" : "Không hoạt động"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                )
            ),
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
        ConstrainedBox(
          constraints: BoxConstraints(
              maxWidth: Utilities.screen(context).w / 3
          ),
          child: Text(data, style: TextStyles.def.size(12).colors(MyColor.slateGray), textAlign: TextAlign.end),
        )
      ]),
    );
  }


}