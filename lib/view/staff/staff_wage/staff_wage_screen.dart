import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/staff_wage/staff_wage_controller.dart';

import '../bloc/staff_bloc.dart';

class StaffWageScreen extends BaseView<StaffWageController> {
  const StaffWageScreen({super.key});

  @override
  StaffWageController createController(BuildContext context)
  => StaffWageController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: _body(),
    );
  }

  Widget _body() {
    if (controller.screenStateIsLoading) {
      return const Center(child: WidgetLoading());
    } else if (controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                Utilities.retryButton(() => controller.onGetListPayRoll()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
        if(state.listPayroll.isEmpty) {
          return WidgetListView(
            onRefresh: () async => controller.onGetListPayRoll(),
            children: [Utilities.listEmpty()]
          );
        }
        return WidgetListView.builder(
          onRefresh: () async => controller.onGetListPayRoll(),
          itemCount: state.listPayroll.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () => controller.toDetailStaffWage(state.listPayroll[index]),
                child: WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                state.listPayroll[index].infoStaff?.name ?? "Đang cập nhật",
                                style: TextStyles.def.bold.size(17),
                              ),
                            ),
                            controller.statusWage(state, index),
                          ],
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
                                            "Tháng ${state.listPayroll[index].month ?? "Đang cập nhật"}",
                                            style: TextStyles.def.colors(MyColor.hideText).size(12),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Lương thanh toán: ${state.listPayroll[index].salary?.toCurrency(suffix: 'đ')}",
                                      style: TextStyles.def,
                                    ),
                                    _infoCount(title: "Email", data: state.listPayroll[index].infoStaff?.email ?? "Đang cập nhật"),
                                    _infoCount(title: "Số điện thoại", data: state.listPayroll[index].infoStaff?.phone ?? "Đang cập nhật"),
                                    _infoCount(title: "Ngân hàng", data: state.listPayroll[index].infoStaff?.codeBank ?? "Đang cập nhật"),
                                    _infoCount(title: "Tài khoản", data: state.listPayroll[index].infoStaff?.accountBank ?? "Đang cập nhật"),
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
      });
    }
  }

  Widget _infoCount({required String title, String? data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(title, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
        Expanded(child: Divider(height: 10, indent: 5, endIndent: 5, color: MyColor.sliver.o3)),
        Text(
          data == "" ? "Đang cập nhật" : data!,
          style: TextStyles.def.size(12).colors(MyColor.slateGray),
        ),
      ]),
    );
  }
}