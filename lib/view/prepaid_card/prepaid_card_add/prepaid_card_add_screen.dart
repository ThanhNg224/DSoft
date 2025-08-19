import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_add/prepaid_card_add_controller.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_add/prepaid_card_add_cubit.dart';

class PrepaidCardAddScreen extends BaseView<PrepaidCardAddController> {
  static const String router = "/PrepaidCardAddScreen";
  const PrepaidCardAddScreen({super.key});

  @override
  PrepaidCardAddController createController(BuildContext context)
  => PrepaidCardAddController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<PrepaidCardAddCubit, PrepaidCardAddState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.title),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: Row(
                  children: [
                    if(controller.args != null)Expanded(
                      child: WidgetButton(
                        title: "Xóa thẻ trả trước",
                        vertical: 0,
                        borderColor: MyColor.red,
                        color: MyColor.nowhere,
                        styleTitle: TextStyles.def.colors(MyColor.red),
                        onTap: ()=> controller.onDeletePrepaid(),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: WidgetButton(
                        title: state.title,
                        vertical: 0,
                        onTap: ()=> controller.onAddEditPrepaidCard(state),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: WidgetListView(children: [
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetInput(
                      title: "Tên thẻ",
                      tick: true,
                      controller: controller.cName,
                      hintText: "Nhập tên thẻ",
                      validateValue: state.vaName,
                    ),
                    WidgetInput(
                      title: "Mệnh giá",
                      controller: controller.cFaceValue,
                      validateValue: state.vaFaceValue,
                      hintText: "Mệnh giá sử dụng",
                      inputFormatters: [AutoFormatInput()],
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                      ),
                      tick: true,
                    ),
                    WidgetInput(
                      title: "Giá bán",
                      controller: controller.cPrice,
                      validateValue: state.vaPrice,
                      hintText: "Nhập giá bán",
                      inputFormatters: [AutoFormatInput()],
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                      ),
                      tick: true,
                    ),
                    WidgetInput(
                      title: "Thời gian sử dụng (ngày)",
                      controller: controller.cUseTime,
                      // validateValue: state.vaPrice,
                      hintText: "Nhập thời gian sử dụng",
                      inputFormatters: [AutoFormatInput(type: TypeFormatInput.number)],
                      keyboardType: TextInputType.number,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("Ngày", style: TextStyles.def.bold.colors(MyColor.hideText)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(children: [
                        Text("Trạng thái: ", style: TextStyles.def.size(18).bold),
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 1000),
                            transitionBuilder: (child, animation) {
                              final curved = CurvedAnimation(
                                parent: animation,
                                curve: Curves.elasticInOut,
                              );
                              return ScaleTransition(
                                  scale: curved,
                                  alignment: Alignment.centerLeft,
                                  child: child
                              );
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              key: ValueKey(state.status),
                              child: Text(
                                state.status == "lock" ? "Khóa" : "Kích hoạt",
                                textAlign: TextAlign.left,
                                style: TextStyles.def.size(18).bold.colors(state.status == "lock" ? MyColor.red : MyColor.green),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.change_circle_sharp),
                          onPressed: ()=> context.read<PrepaidCardAddCubit>().changeStatusPrepaidCardAdd(),
                        )
                      ]),
                    ),
                    WidgetInput(
                      title: "Mô tả thẻ",
                      hintText: "Nhập mô tả",
                      maxLines: 3,
                      controller: controller.cNote,
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Cài đặt hoa hồng thẻ trả trước", style: TextStyles.def.bold.size(18)),
              ),
              WidgetBoxColor(
                  closed: ClosedEnd.start,
                  closedBot: ClosedEnd.end,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Hệ thống sẽ ưu tiên tính tiền cố định trước rồi mới đến tính theo hoa hồng",
                          style: TextStyles.def.colors(MyColor.red)),
                      const SizedBox(height: 10),
                      WidgetInput(
                        title: "Nhân viên",
                        hintText: "Trả số tiền cố định",
                        controller: controller.cPriceForStaff,
                        inputFormatters: [AutoFormatInput()],
                        keyboardType: TextInputType.number,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(child: Text("Trả theo", style: TextStyles.def)),
                        Text("${state.commissionStaffPercent}%", style: TextStyles.def)
                      ]),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackShape: const RectangularSliderTrackShape(),
                          trackHeight: 3.0,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                        ),
                        child: Slider(
                          value: state.commissionStaffPercent.toDouble(),
                          min: 0,
                          max: 100,
                          activeColor: MyColor.slateBlue,
                          label: 50.round().toString(),
                          onChanged: (double value) {
                            context.read<PrepaidCardAddCubit>().changePercent(value.round());
                          },
                        ),
                      ),
                    ],
                  )
              ),
            ]),
          ),
        );
      }
    );
  }


}