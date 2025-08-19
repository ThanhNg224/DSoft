import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_staff.dart';
import 'package:spa_project/view/debt_management/bill_collect_add/bill_collect_add_controller.dart';
import 'package:spa_project/view/debt_management/bill_collect_add/bill_collect_add_cubit.dart';

class BillCollectAddScreen extends BaseView<BillCollectAddController> {
  static const String router = "/BillCollectAddScreen";
  const BillCollectAddScreen({super.key});

  @override
  BillCollectAddController createController(BuildContext context)
  => BillCollectAddController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<BillCollectAddCubit, BillCollectAddState>(
        builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: state.titleAppBar,
          ),
          bottomNavigationBar: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: WidgetButton(
                title: "Lưu thông tin phiếu thu",
                vertical: 0,
                onTap: ()=> controller.onSaveBill(),
              ),
            ),
          ),
          body: BlocBuilder<BillCollectAddCubit, BillCollectAddState>(
            builder: (context, state) {
              if(controller.screenStateIsError) {
                return SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          controller.errorWidget,
                          Utilities.retryButton(() => controller.getListStaff()),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return WidgetListView(
                children: [
                  WidgetBoxColor(
                    closed: ClosedEnd.start,
                    closedBot: ClosedEnd.end,
                    child: Column(
                      children: [
                        Row(children: [
                          Text("Người nộp tiền", style: TextStyles.def),
                          const SizedBox(width: 5),
                          Text("*", style: TextStyles.def.size(18).colors(MyColor.red))
                        ]),
                        const SizedBox(height: 5),
                        GestureDetector(
                          onTap: controller.onOpenViewSearch,
                          child: SizedBox(
                            width: double.infinity,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: state.vaName.isEmpty ? MyColor.borderInput : MyColor.red)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                                child: state.vaName.isEmpty ? Text(controller.nameCustomer.name ?? "Nhập người nộp tiền",
                                    style: TextStyles.def.colors(controller.nameCustomer.name == null
                                        ? MyColor.hideText
                                        : MyColor.darkNavy
                                    )
                                ) : Text(state.vaName, style: TextStyles.def.colors(MyColor.red)),
                              ),
                            ),
                          ),
                        ),
                        _boxBookTime(state),
                        WidgetInput(
                          title: "Số tiền",
                          hintText: "Nhập số tiền",
                          tick: true,
                          validateValue: state.vaPrice,
                          controller: controller.cPrice,
                          inputFormatters: [AutoFormatInput()],
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        WidgetDropDow<ModelPaymentMethod>(
                          title: "Phương thức thanh toán",
                          content: ModelPaymentMethod.listPaymentMethod.map((item) => WidgetDropSpan(value: item))
                              .toList(),
                          tick: true,
                          topTitle: "Hình thức",
                          getValue: (item) => item.name,
                          value: state.methodPayment,
                          onSelect: (item) => state.methodPayment = item
                        ),
                        WidgetDropDow<Data>(
                            title: "Chọn nhân viên",
                            validate: state.vaStaff,
                            content: state.listStaff.map((item) => WidgetDropSpan(value: item)).toList(),
                            tick: true,
                            topTitle: "Nhân viên phụ trách",
                            getValue: (item) => item.name ?? "Đang cập nhật",
                            value: state.choseStaff,
                            onSelect: (item) => state.choseStaff = item
                        ),
                        Utilities.viewSpaDefault,
                        WidgetInput(
                          title: "Ghi chú",
                          maxLines: 3,
                          controller: controller.cNote,
                          hintText: "Nhập nội dung",
                        ),
                      ],
                    ),
                  )
                ]
              );
            }
          ),
        );
      }
    );
  }

  Widget _boxBookTime(BillCollectAddState state) {
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