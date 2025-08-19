import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/debt_management/debt_add_collection/debt_add_collection_controller.dart';
import 'package:spa_project/view/staff_add_edit/staff_add_edit_screen.dart';

import 'debt_add_collection_cubit.dart';

class DebtAddCollectionScreen extends BaseView<DebtAddCollectionController> {
  static const String router = "/DebtAddCollectionScreen";
  const DebtAddCollectionScreen({super.key});

  @override
  DebtAddCollectionController createController(BuildContext context)
  => DebtAddCollectionController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: Utilities.dismissKeyboard,
      child: BlocBuilder<DebtAddCollectionCubit, DebtAddCollectionState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.title),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(
                    top: 15,
                    bottom: 35
                )),
                child: controller.args?.data == null || controller.args?.data?.status == 0 ? Row(
                  children: [
                    Expanded(
                      child: WidgetButton(
                        title: state.titleButton,
                        onTap: ()=> controller.onCreateDebt(state),
                      ),
                    ),
                    if(controller.args?.data != null) const SizedBox(width: 10),
                    if(controller.args?.data != null) Expanded(
                      child: WidgetButton(
                        title: "Than toán",
                        color: MyColor.green.o6,
                        onTap: () => controller.onPayment(),
                      ),
                    ),
                  ],
                ) : Center(child: Text("Đã thanh toán", style: TextStyles.def.bold.colors(MyColor.green))),
              ),
            ),
            body: WidgetListView(children: [
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  WidgetInput(
                    title: controller.isInfoViewPaidDebt || controller.isViewPaidDebt ? "Đối tác" : "Người nợ tiền",
                    hintText: controller.isInfoViewPaidDebt || controller.isViewPaidDebt
                        ? "Nhập tên Đối tác" : "Nhập tên người nợ tiền",
                    controller: controller.cName,
                    validateValue: state.vaName,
                  ),
                  WidgetInput(
                    title: "Số tiền",
                    hintText: "Nhập số tiền nợ",
                    keyboardType: TextInputType.number,
                    inputFormatters: [AutoFormatInput()],
                    controller: controller.cPrice,
                    validateValue: state.vaPrice,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text("Thời gian tạo công nợ", style: TextStyles.def),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: ()=> controller.onChoseDate(),
                    child: SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: MyColor.borderInput),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Text(state.dateTimeValue.formatDateTime(), style: TextStyles.def),
                        ),
                      ),
                    ),
                  ),
                  WidgetDropDow<Data>(
                    title: "Chọn nhân viên",
                    topTitle: "Nhân viên phụ trách",
                    content: state.listStaff.map((item) => WidgetDropSpan(value: item)).toList(),
                    getValue: (item) => item.name ?? "",
                    value: state.choseStaff,
                    validate: state.vaStaff,
                    onCreate: () => Navigator.pushNamed(context, StaffAddEditScreen.router)
                        .whenComplete(controller.onGetListStaff),
                    onSelect: (item) => state.choseStaff = item,
                  ),
                  WidgetInput(
                    title: "Nội dung nợ",
                    hintText: "Nhập nội dung nợ",
                    maxLines: 3,
                    controller: controller.cNote,
                  ),
                ]),
              ),
              const SizedBox(height: 20),
              if(controller.args?.data != null) WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _itemInfoMore(title: "Số tiền nợ:", value: controller.args?.data?.total?.toCurrency(suffix: "đ") ?? "0"),
                    _itemInfoMore(title: "Đã trả:", value: controller.args?.data?.totalPayment?.toCurrency(suffix: "đ") ?? "0"),
                    _itemInfoMore(title: "Số lần trả:", value: (controller.args?.data?.numberPayment ?? "0").toString()),
                  ],
                ),
              )
            ]),
          );
        }
      ),
    );
  }

  Widget _itemInfoMore({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(title, style: TextStyles.def.bold.colors(MyColor.slateGray)),
        Expanded(child: Transform.translate(
          offset: const Offset(0, 6),
          child: const Divider(indent: 5, endIndent: 5, height: 1, color: MyColor.hideText))
        ),
        Text(value, style: TextStyles.def.colors(MyColor.slateGray)),
      ]),
    );
  }
}