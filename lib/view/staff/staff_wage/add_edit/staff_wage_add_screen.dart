import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/staff/staff_wage/add_edit/staff_wage_add_controller.dart';
import 'package:spa_project/view/staff/staff_wage/add_edit/staff_wage_add_cubit.dart';

class StaffWageAddScreen extends BaseView<StaffWageAddController> {
  static const String router = "/StaffWageAddScreen";
  const StaffWageAddScreen({super.key});

  @override
  StaffWageAddController createController(BuildContext context)
  => StaffWageAddController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<StaffWageAddCubit, StaffWageAddState>(
        builder: (context, state) {
        return Scaffold(
          appBar: const WidgetAppBar(title: "Tính lương nhân viên"),
          backgroundColor: MyColor.softWhite,
          bottomNavigationBar: ColoredBox(
            color: MyColor.white,
            child: SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(
                  top: 10,
                  bottom: 20
                )),
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(child: Text("Tổng lương:", style: TextStyles.def)),
                      Text(controller.totalPricePay(state).toCurrency(suffix: "đ"), style: TextStyles.def),
                    ]),
                    const SizedBox(height: 10),
                    WidgetButton(
                      title: "Tính lương",
                      vertical: 10,
                      onTap: ()=> controller.onSalaryCalculation(state),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: WidgetListView(
              children: [
                WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WidgetDropDow<staff.Data>(
                            title: "Chọn nhân viên",
                            topTitle: "Nhân viên",
                            content: state.listStaff
                                .map((item) => WidgetDropSpan(value: item))
                                .toList(),
                            value: state.choseStaff,
                            getValue: (item) => item.name ?? "Đang cập nhật",
                            onSelect: (value) {
                              state.choseStaff = value;
                              controller.onGetMulti();
                            }
                        ),
                        const SizedBox(height: 5),
                        Text("Tháng", style: TextStyles.def),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: controller.onChoseDate,
                          child: SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: MyColor.borderInput)
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                                  child: Text("Tháng ${state.dateTimeValue.formatDateTime(format: "MM")}, "
                                      "năm ${state.dateTimeValue.formatDateTime(format: "yyyy")}",
                                      style: TextStyles.def)
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text("Tổng ngày lương", style: TextStyles.def),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: controller.onChoseDay,
                          child: SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: MyColor.borderInput)
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                                  child: Text(state.dayWage.formatDateTime(format: "dd"), style: TextStyles.def)
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Thông tin lương cơ bản", style: TextStyles.def.bold.size(18)),
                ),
                if(state.choseStaff != null) WidgetBoxColor(
                  closed: ClosedEnd.start,
                  closedBot: ClosedEnd.end,
                  child: Column(
                    children: [
                      _itemInfoWage(
                          title: "Lương cứng:",
                          data: state.choseStaff?.fixedSalary?.toCurrency(suffix: "đ") ?? "",
                          icon: Icons.price_change_outlined
                      ),
                      _itemInfoWage(
                          title: "Trợ cấp:",
                          data: state.choseStaff?.allowance?.toCurrency(suffix: "đ") ?? "",
                          icon: Icons.price_change_outlined
                      ),
                      _itemInfoWage(
                          title: "Tiền bảo hiểm:",
                          data: state.choseStaff?.insurance?.toCurrency(suffix: "đ") ?? "",
                          icon: CupertinoIcons.checkmark_shield
                      ),
                      _itemInfoWage(
                          title: "Số ngày làm thực tế:",
                          data: "${state.listTimeSheet.length} ngày",
                          icon: Icons.date_range
                      ),
                    ],
                  ),
                ) else Text("Vui lòng chọn nhân viên cần tính lương", style: TextStyles.def.semiBold.colors(MyColor.slateGray), textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text("Thông tin thưởng phạt", style: TextStyles.def.bold.size(18)),
                ),
                if(state.choseStaff != null) WidgetBoxColor(
                  closed: ClosedEnd.start,
                  closedBot: ClosedEnd.end,
                  child: Column(
                    children: [
                      _itemInfoWageMore(
                          title: "Tiền thưởng: +",
                          state: state,
                          price: state.listBonus
                              .fold(0, (sum, item) => sum + (item.money ?? 0))
                      ),
                      _itemInfoWageMore(
                          title: "Tiền phạt: -",
                          state: state,
                          price: state.listPunish
                              .fold(0, (sum, item) => sum + (item.money ?? 0))
                      ),
                      _itemInfoWageMore(
                          title: "Hoa hồng: +",
                          state: state,
                          price: state.listAgency
                              .fold(0, (sum, item) => sum + (item.money ?? 0))
                      ),
                    ],
                  ),
                ) else Text("Vui lòng chọn nhân viên cần tính lương", style: TextStyles.def.semiBold.colors(MyColor.slateGray), textAlign: TextAlign.center),
              ]
          ),
        );
      }
    );
  }

  Widget _itemInfoWage({required String title, required String data, Color color = MyColor.slateGray, required IconData icon}) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: MyColor.slateGray),
        const SizedBox(width: 5),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Utilities.screen(context).w/2
          ),
          child: Text(
            title,
            style: TextStyles.def.semiBold.colors(MyColor.slateGray),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 6),
        const Expanded(child: Divider(thickness: 1)),
        const SizedBox(width: 6),
        Text(
          data,
          style: TextStyles.def.colors(color),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          textAlign: TextAlign.right,
        ),
      ],
    ),
  );

  Widget _itemInfoWageMore({required String title, int price = 0, required StaffWageAddState state}) {
    bool isChose = state.listCheckBonusPunish.contains(price);
    return GestureDetector(
      onTap: () => controller.checkBoxBonusPunish(price),
      child: Material(
        color: MyColor.nowhere,
        child: Row(
          children: [
            Expanded(child: Opacity(
                opacity: isChose ? 1 : 0.3,
                child: Text("$title ${price.toCurrency(suffix: "đ")}", style: TextStyles.def.lineThrough(thickness: isChose ? 0 : 2))
            )),
            WidgetCheckbox(
                onChanged: (p0) => controller.checkBoxBonusPunish(price),
                value: isChose
            ),
          ],
        ),
      ),
    );
  }
}