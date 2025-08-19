import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_partner.dart' as partner;
import 'package:spa_project/view/warehouse_import/bloc/warehouse_import_bloc.dart';
import 'package:spa_project/view/warehouse_import/warehouse_import_controller.dart';

class WarehouseImportScreen extends BaseView<WarehouseImportController> {
  static const String router = "/WarehouseImportScreen";
  const WarehouseImportScreen({super.key});

  @override
  WarehouseImportController createController(BuildContext context)
  => WarehouseImportController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: Utilities.dismissKeyboard,
      child: BlocBuilder<WarehouseImportBloc, WarehouseImportState>(
          builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: const WidgetAppBar(title: "Nhập kho"),
            body: _body(state),
            bottomNavigationBar: ColoredBox(
              color: MyColor.white,
              child: SizedBox(
                height: 95,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 30, top: 15),
                  child: WidgetButton(
                    vertical: 0,
                    title: "Nhập kho",
                    onTap: () => controller.onImportProduct(state),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _body(WarehouseImportState state) {
    if(controller.screenStateIsLoading) {
      return WidgetListView(
        children: List.generate(6, (_) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              width: double.infinity,
              height: 130,
              radius: 20,
            ),
          );
        })
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
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.onGetMulti()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            child: WidgetBoxColor(
              closed: ClosedEnd.start,
              closedBot: ClosedEnd.end,
              child: WidgetDropDow<partner.Data>(
                  title: "Chọn thương hiệu",
                  content: state.listPartner.map((item) => WidgetDropSpan(value: item)).toList(),
                  getValue: (item) => item.name ?? "",
                  onCreate: controller.toAddPartner,
                  value: state.chosePartner,
                  onSelect: (value) => state.chosePartner = value
              ),
            ),
          ),
          TextButton(
              onPressed: controller.popupProduct,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.add_home_work_rounded, color: MyColor.slateBlue),
                  Text("  Nhập sản phẩm kho", style: TextStyles.def.bold.colors(MyColor.slateBlue).size(12)),
                ],
              )
          ),
          if(state.listImport.isNotEmpty) Expanded(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
            child: WidgetListView.builder(
              itemCount: state.listImport.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return WidgetBoxColor(
                  closed: index == 0 ? ClosedEnd.start : null,
                  closedBot: index == state.listImport.length - 1 ? ClosedEnd.end : null,
                  child: Row(children: [
                    WidgetImage(imageUrl: state.listImport[index].image, width: 100, height: 100),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.listImport[index].name ?? "", style: TextStyles.def.bold.size(16),
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text(state.listImport[index].price.toCurrency(suffix: "đ"), style: TextStyles.def.colors(MyColor.hideText),
                              maxLines: 1, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: WidgetInput(
                        controller: state.listImport[index].quantityController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [AutoFormatInput(type: TypeFormatInput.number)],
                      ),
                    )
                  ]),
                );
              },
            ),
          )) else Utilities.listEmpty(content: "Vui lòng chọn sản phẩm")
        ],
      );
    }
  }

}