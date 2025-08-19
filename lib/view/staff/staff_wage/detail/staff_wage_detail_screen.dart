import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/staff_wage/detail/staff_wage_detail_controller.dart';
import 'package:spa_project/view/staff/staff_wage/detail/staff_wage_detail_cubit.dart';

class StaffWageDetailScreen extends BaseView<StaffWageDetailController> {
  static const String router = "/StaffWageDetailScreen";
  const StaffWageDetailScreen({super.key});

  @override
  StaffWageDetailController createController(BuildContext context)
  => StaffWageDetailController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<StaffWageDetailCubit, StaffWageDetailState>(
      builder: (context, state) {
        print(state.data?.status);
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: const WidgetAppBar(title: "Chi tiết bảng lương nhân viên"),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(
                top: 15,
                bottom: 35
              )),
              child: Row(
                children: [
                  if(state.data?.status == "new") Expanded(
                    child: WidgetButton(
                      title: "Phê duyệt",
                      onTap: ()=> controller.onVerification(),
                    ),
                  ),
                  if(state.data?.status == "browse") Expanded(
                    child: WidgetButton(
                      title: "Thanh toán lương",
                      onTap: ()=> controller.onPayment(),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: WidgetListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Thông tin nhân viên", style: TextStyles.def.bold.size(18))
                ),
              ),
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.data?.infoStaff?.name ?? "Đang cập nhật",
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
                                        "Tháng ${state.data?.month ?? "Đang cập nhật"}",
                                        style: TextStyles.def.colors(MyColor.hideText).size(12),
                                      ),
                                    )
                                  ],
                                ),
                                _infoCount(title: "Email", data: state.data?.infoStaff?.email ?? "Đang cập nhật"),
                                _infoCount(title: "Số điện thoại", data: state.data?.infoStaff?.phone ?? "Đang cập nhật"),
                                _infoCount(title: "Ngân hàng", data: state.data?.infoStaff?.codeBank ?? "Đang cập nhật"),
                                _infoCount(title: "Tài khoản", data: state.data?.infoStaff?.accountBank ?? "Đang cập nhật"),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Thông tin lương", style: TextStyles.def.bold.size(18))
                ),
              ),
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("Trạng thái", style: TextStyles.def.bold.size(17))),
                          controller.statusWage(state),
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
                                  _infoCount(title: "Lương cứng", data: state.data?.fixedSalary?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  _infoCount(title: "Công", data: "${state.data?.workingDay}/${state.data?.work}"),
                                  _infoCount(title: "Phụ cấp", data: state.data?.infoStaff?.allowance?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  _infoCount(title: "Tiền Hoa hồng", data: state.data?.commission?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  _infoCount(title: "Tiền Thưởng", data: state.data?.bonus?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  _infoCount(title: "Tiền Phạt", data: state.data?.punish?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  _infoCount(title: "Bảo hiểm", data: state.data?.infoStaff?.insurance?.toCurrency(suffix: "đ") ?? "Đang cập nhật"),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Tổng lương thanh toán: ${state.data?.salary?.toCurrency(suffix: 'đ')}",
                                    style: TextStyles.def,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        );
      }
    );
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