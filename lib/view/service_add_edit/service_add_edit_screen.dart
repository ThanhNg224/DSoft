import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as cate;
import 'package:spa_project/view/service_add_edit/service_add_edit_controller.dart';
import 'package:spa_project/view/service_add_edit/service_add_edit_cubit.dart';

class ServiceAddEditScreen extends BaseView<ServiceAddEditController> {
  static const String router = "/ServiceAddEditScreen";
  const ServiceAddEditScreen({super.key});

  @override
  ServiceAddEditController createController(BuildContext context)
  => ServiceAddEditController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ServiceAddEditCubit, ServiceAddEditState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(
              title: state.titleApp,
            ),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: WidgetButton(
                  title: state.titleApp,
                  vertical: 0,
                  onTap: controller.onAddEditService,
                ),
              ),
            ),
            body: _body(state)
          ),
        );
      }
    );
  }

  Widget _body(ServiceAddEditState state) {
    if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.getListCategory()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return WidgetListView(
        children: [
          WidgetBoxColor(
            closed: ClosedEnd.start,
            child: _boxImage(state),
          ),
          WidgetBoxColor(
            // closed: ClosedEnd.start,
            child: WidgetInput(
              title: "Tên dịch vụ",
              hintText: "Nhập tên dịch vụ",
              tick: true,
              validateValue: state.vaName,
              controller: controller.cName,
            ),
          ),
          WidgetBoxColor(
            child: WidgetDropDow<cate.Data>(
              title: "Chọn nhóm dịch vụ",
              topTitle: "Nhóm dịch vụ",
              content: List.generate(state.listCate.length, (index) {
                return WidgetDropSpan(value: state.listCate[index]);
              }),
              validate: state.vaCate,
              tick: true,
              getValue: (item) => item.name ?? "",
              value: controller.valueCateSelect,
              onSelect: (item) => controller.valueCateSelect = item,
            )
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Mã dịch vụ",
              controller: controller.cCode,
              hintText: "Nhập mã dịch vụ",
            ),
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Giá dịch vụ",
              controller: controller.cPrice,
              validateValue: state.vaPrice,
              hintText: "Nhập giá dịch vụ",
              inputFormatters: [AutoFormatInput()],
              keyboardType: TextInputType.number,
              suffixIcon: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
              ),
              tick: true,
            ),
          ),
          WidgetBoxColor(
            child: WidgetInput(
              controller: controller.cDuration,
              title: "Thời lượng (phút)",
              hintText: "Nhập thời lượng",
              inputFormatters: [AutoFormatInput(type: TypeFormatInput.notCharacters)],
              keyboardType: TextInputType.number,
            ),
          ),
          WidgetBoxColor(
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
                    key: ValueKey(state.statusService),
                    child: Text(
                      state.statusService == StatusAccountStaff.isLock ? "Khóa" : "Kích hoạt",
                      textAlign: TextAlign.left,
                      style: TextStyles.def.size(18).bold.colors(StatusAccountStaff.color(state.statusService)),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.change_circle_sharp),
                onPressed: context.read<ServiceAddEditCubit>().changeStatusService,
              )
            ])
          ),
          WidgetBoxColor(
            closedBot: ClosedEnd.end,
            child: WidgetInput(
              title: "Mô tả",
              controller: controller.cDescription,
              hintText: "Nhập mô tả",
              maxLines: 3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text("Cài đặt hoa hồng dịch vụ", style: TextStyles.def.bold.size(18)),
          ),
          WidgetBoxColor(
            closed: ClosedEnd.start,
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
                      context.read<ServiceAddEditCubit>().changePercent(commissionStaffPercent: value.round());
                    },
                  ),
                ),
              ],
            )
          ),
          WidgetBoxColor(
            closedBot: ClosedEnd.end,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WidgetInput(
                  title: "Người giới thiệu",
                  hintText: "Trả số tiền cố định",
                  controller: controller.cPriceForAffiliate,
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
                  Text("${state.commissionAffiliatePercent}%", style: TextStyles.def)
                ]),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackShape: const RectangularSliderTrackShape(),
                    trackHeight: 3.0,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                  ),
                  child: Slider(
                    value: state.commissionAffiliatePercent.toDouble(),
                    min: 0,
                    max: 100,
                    activeColor: MyColor.slateBlue,
                    label: 50.round().toString(),
                    onChanged: (double value) {
                      context.read<ServiceAddEditCubit>().changePercent(commissionAffiliatePercent: value.round());
                    },
                  ),
                ),
              ],
            )
          )
        ]
      );
    }
  }

  Widget _boxImage(ServiceAddEditState state) {
    return GestureDetector(
      onTap: controller.onChoseImage,
      child: AspectRatio(
        aspectRatio: 3 / 1.7,
        child: DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: MyColor.borderInput
          ),
          child: Center(
            child: WidgetImage(
                imageUrl: state.image,
                width: double.infinity,
                errorImage: const Icon(
                  Icons.add,
                  color: MyColor.sliver,
                  size: 80,
                )
            ),
          ),
        ),
      ),
    );
  }
}