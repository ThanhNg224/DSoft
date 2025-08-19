import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_product.dart' as product;
import 'package:spa_project/model/response/model_list_service.dart' as service;
import 'package:spa_project/view/combo_treatment/add_edit/combo_add_edit_controller.dart';
import 'package:spa_project/view/combo_treatment/add_edit/combo_add_edit_cubit.dart';

import '../../../common/format_input/auto_money_input.dart';

class ComboAddEditScreen extends BaseView<ComboAddEditController> {
  static const String router = "/ComboAddEditScreen";
  const ComboAddEditScreen({super.key});

  @override
  ComboAddEditController createController(BuildContext context)
  => ComboAddEditController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ComboAddEditCubit, ComboAddEditState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleApp),
            body: WidgetListView(children: [
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetInput(
                      title: "Tên combo",
                      hintText: "Nhập tên combo",
                      tick: true,
                      controller: controller.cName,
                      validateValue: state.vaName,
                    ),
                    WidgetInput(
                      title: "Giá combo",
                      hintText: "Nhập giá combo",
                      tick: true,
                      inputFormatters: [AutoFormatInput()],
                      controller: controller.cPrice,
                      keyboardType: TextInputType.number,
                      validateValue: state.vaPrice,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
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
                          onPressed: ()=> context.read<ComboAddEditCubit>().changeStatusComboAddEdit(),
                        )
                      ]),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 200,
                        child: WidgetButton(
                          title: "Thêm sản phẩm",
                          iconLeading: Icons.add,
                          vertical: 7,
                          onTap: () => controller.onAddProduct(state),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(state.dataProduct.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(children: [
                          Expanded(flex: 3, child: WidgetDropDow<product.Data>(
                            title: "Chọn sản phẩm",
                            content: state.listProduct.map((item) => WidgetDropSpan(value: item)).toList(),
                            getValue: (value) => value.name ?? "Đang cập nhật",
                            value: state.dataProduct[index].value,
                            onSelect: (value) => state.dataProduct[index].value = value,
                          )),
                          const SizedBox(width: 10),
                          Expanded(flex: 1, child: WidgetInput(
                            textAlign: TextAlign.center,
                            inputFormatters: [AutoFormatInput(type: TypeFormatInput.number)],
                            keyboardType: TextInputType.number,
                            controller: state.dataProduct[index].cQuantity,
                          )),
                          IconButton(
                            onPressed: () => controller.removeProduct(index, state),
                            icon: const Icon(CupertinoIcons.delete, color: MyColor.red)
                          )
                        ]),
                      );
                    }),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        width: 200,
                        child: WidgetButton(
                          title: "Thêm dịch vụ",
                          iconLeading: Icons.add,
                          vertical: 7,
                          onTap: () => controller.onAddService(state),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(state.dataService.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(children: [
                          Expanded(flex: 3, child: WidgetDropDow<service.Data>(
                            title: "Chọn sản phẩm",
                            content: state.listService.map((item) => WidgetDropSpan(value: item)).toList(),
                            getValue: (value) => value.name ?? "Đang cập nhật",
                            value: state.dataService[index].value,
                            onSelect: (value) => state.dataService[index].value = value,
                          )),
                          const SizedBox(width: 10),
                          Expanded(flex: 1, child: WidgetInput(
                            textAlign: TextAlign.center,
                            inputFormatters: [AutoFormatInput(type: TypeFormatInput.number)],
                            keyboardType: TextInputType.number,
                            controller: state.dataService[index].cQuantity,
                          )),
                          IconButton(
                              onPressed: () => controller.removeService(index, state),
                              icon: const Icon(CupertinoIcons.delete, color: MyColor.red)
                          )
                        ]),
                      );
                    }),
                    WidgetInput(
                      controller: controller.cDuration,
                      title: "Thời lượng (phút)",
                      hintText: "Nhập thời lượng",
                      inputFormatters: [AutoFormatInput(type: TypeFormatInput.notCharacters)],
                      keyboardType: TextInputType.number,
                    ),
                    WidgetInput(
                      title: "Mô tả",
                      maxLines: 3,
                      hintText: "Nhập nội dung",
                      controller: controller.cDescription,
                    ),
                  ],
                )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text("Cài đặt hoa hồng combo liệu trình", style: TextStyles.def.bold.size(18)),
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
                          context.read<ComboAddEditCubit>().changePercentComboAddEdit(value.round());
                        },
                      ),
                    ),
                  ],
                )
              ),
            ]),
            bottomNavigationBar: ColoredBox(
              color: MyColor.white,
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsetsDirectional.only(
                    bottom: 35, top: 15
                  )),
                  child: WidgetButton(
                    title: state.titleApp,
                    onTap: () => controller.onAddEdit(state),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }


}