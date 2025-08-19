import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_repo.dart';
import 'package:spa_project/view/warehouse/warehouse_controller.dart';
import 'package:spa_project/view/warehouse/warehouse_cubit.dart';
import 'package:spa_project/view/warehouse_history/warehouse_history_screen.dart';
import 'package:spa_project/view/warehouse_import/warehouse_import_screen.dart';

class WarehouseScreen extends BaseView<WarehouseController> {
  static const String router = "/WarehouseScreen";
  const WarehouseScreen({super.key});

  @override
  WarehouseController createController(BuildContext context)
  => WarehouseController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: WidgetAppBar(
        title: "Kho hàng",
        actionIcon: WidgetButton(
          iconLeading: Icons.add,
          vertical: 0,
          horizontal: 10,
          onTap: () => controller.onAddEditRepo(),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return const Padding(
        padding: EdgeInsets.all(20.0),
        child: WidgetShimmer(
          width: double.infinity,
          height: 300,
          radius: 20,
        ),
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
                Utilities.retryButton(() => controller.getListRepo()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<WarehouseCubit, List<Data>>(
        builder: (context, data) {
          return WidgetListView(
            onRefresh: () async => controller.getListRepo(isLoad: false),
            children: [
              WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: data.isEmpty ? ClosedEnd.end : null,
                child: DecoratedBox(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyColor.sliver),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Row(children: [
                      SizedBox(
                        width: 50,
                        child: Text("ID", style: TextStyles.def.bold.colors(MyColor.slateGray))
                      ),
                      const SizedBox(width: 10),
                      Text("Tên kho", style: TextStyles.def.bold.colors(MyColor.slateGray)),
                    ]),
                  ),
                )
              ),
              if(data.isEmpty) 
                Utilities.listEmpty()
              else ...List.generate(data.length, (index) {
                return WidgetBoxColor(
                  closedBot: index == data.length - 1 ? ClosedEnd.end : null,
                  child: WidgetPopupMenu(
                    name: "popup_repo_$index",
                    menu: [
                      WidgetMenuButton(
                          name: "Sửa kho",
                          icon: Icons.edit,
                          onTap: () => controller.onAddEditRepo(
                            id: data[index].id,
                            name: data[index].name,
                            describe: data[index].description
                          )
                      ),
                      WidgetMenuButton(
                          name: "Nhập sản phẩm vào kho",
                          icon: Icons.add_home_work_rounded,
                          onTap: () => Navigator.pushNamed(context, WarehouseImportScreen.router, arguments: data[index].id)
                      ),
                      WidgetMenuButton(
                          name: "Lịch sử nhập kho",
                          icon: Icons.history,
                          onTap: () => Navigator.pushNamed(context, WarehouseHistoryScreen.router, arguments: data[index].id)
                      ),
                      WidgetMenuButton(
                          name: "Xóa kho",
                          icon: Icons.delete,
                          color: MyColor.red,
                          onTap: () => controller.onDelete(data[index].id, data[index].name)
                      )
                    ],
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: ColoredBox(
                          color: MyColor.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Row(children: [
                              SizedBox(
                                width: 50,
                                child: Text("${data[index].id ?? 0}", style:
                                TextStyles.def.bold.colors(MyColor.slateGray)),
                              ),
                              Expanded(
                                child: Text(data[index].name ?? "", style:
                                TextStyles.def.bold.colors(MyColor.slateGray)),
                              )
                            ]),
                          ),
                        )
                    ),
                  )
                );
              })
            ]
          );
        }
      );
    }
  }
}