import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_bonus/add_edit/staff_bonus_add_controller.dart';
import 'package:spa_project/view/staff/staff_bonus/add_edit/staff_bonus_add_cubit.dart';
import 'package:spa_project/view/staff/staff_bonus/staff_bonus_controller.dart';
import 'package:spa_project/view/staff/staff_controller.dart';

class StaffBonusAddScreen extends BaseView<StaffBonusAddController> {
  static const String router = "/StaffBonusAddScreen";
  const StaffBonusAddScreen({super.key});

  @override
  StaffBonusAddController createController(BuildContext context)
  => StaffBonusAddController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<StaffBonusAddCubit, StaffBonusAddState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.title),
            body: WidgetListView(children: [
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  children: [
                    WidgetDropDow<Data>(
                      title: "Chọn nhân viên",
                      topTitle: "Nhân viên",
                      content: findController<StaffController>()
                          .onTriggerEvent<StaffBloc>().state.listStaff
                          .map((item) => WidgetDropSpan(
                        value: item,
                      )).toList(),
                      value: state.choseStaff,
                      getValue: (item) => item.name ?? "",
                      onSelect: (item) => state.choseStaff = item,
                    ),
                    WidgetInput(
                      controller: controller.cMoney,
                      title: controller.args!.isBonus ? "Tiền thưởng" : "Tiền phạt",
                      hintText: "Nhập tiền thưởng",
                      keyboardType: TextInputType.number,
                      inputFormatters: [AutoFormatInput()],
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                      ),
                    ),
                    _boxBookTime(state),
                    WidgetInput(
                      title: "Ghi chú",
                      maxLines: 3,
                      controller: controller.cNote,
                      hintText: "Nội dung ghi chú",
                    )
                  ],
                )
              )
            ]),
            bottomNavigationBar: controller.args?.model?.status == "new" || controller.args?.model == null ? SizedBox(
              height: 100,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(
                  top: 15,
                  bottom: 35
                )),
                child: Row(
                  children: [
                    Expanded(
                      child: WidgetButton(
                        title: controller.args?.model == null ? state.title : "Sửa thông tin",
                        onTap: () => controller.onUpdate(state),
                      ),
                    ),
                    if(controller.args?.isBonus == true && controller.args?.model != null) const SizedBox(width: 15),
                    if(controller.args?.isBonus == true && controller.args?.model != null) Expanded(
                      child: WidgetButton(
                        title: "Thanh toán",
                        color: MyColor.slateGray,
                        onTap: ()=> findController<StaffBonusController>().onOpenPayment(
                          name: controller.args?.model?.infoStaff?.name,
                          phone: controller.args?.model?.infoStaff?.phone,
                          bonus: controller.args?.model?.money
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ) : const SizedBox(),
          ),
        );
      }
    );
  }

  Widget _boxBookTime(StaffBonusAddState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Text("Thời gian", style: TextStyles.def),
          const SizedBox(width: 5),
          Text("*", style: TextStyles.def.size(18).colors(MyColor.red))
        ]),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: ()=> controller.onOpenSelectDateTime(state),
          child: SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColor.borderInput)
              ),
              child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  child: Text(state.dateTimeValue.formatDateTime(), style: TextStyles.def)
              ),
            ),
          ),
        )
      ],
    );
  }
}