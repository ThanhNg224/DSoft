import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/diagram_room_bed/diagram_room_bed_controller.dart';
import 'package:spa_project/view/diagram_room_bed/diagram_room_bed_cubit.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_controller.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_screen.dart';
import 'package:spa_project/view/order/order_cubit.dart';
import 'package:spa_project/view/order/order_screen.dart';

class DiagramRoomBedScreen extends BaseView<DiagramRoomBedController> {
  static const String router = "/DiagramRoomBedScreen";
  const DiagramRoomBedScreen({super.key});

  @override
  DiagramRoomBedController createController(BuildContext context)
  => DiagramRoomBedController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: "Sơ đồ giường"),
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return const SizedBox();
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
                Utilities.retryButton(() => controller.onGetDiagram()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<DiagramRoomBedCubit, DiagramRoomBedState>(
        builder: (context, state) {
          if(state.diagram.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.onGetDiagram(),
              children: [Utilities.listEmpty()]
            );
          }
          return WidgetListView.builder(
            onRefresh: () async => controller.onGetDiagram(),
            itemCount: state.diagram.length,
            itemBuilder: (context, roomIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text(state.diagram[roomIndex].name ?? "Đang cập nhật", style: TextStyles.def.bold.size(18)),
                        TextButton(
                          onPressed: () => controller.addEditBedOfDiagram.perform(idRoom: state.diagram[roomIndex].id),
                          child: Row(
                            children: [
                              const Icon(Icons.add, color: MyColor.slateBlue),
                              const SizedBox(width: 5),
                              Text("Thêm phòng", style: TextStyles.def.bold.size(10).colors(MyColor.slateBlue))
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  (state.diagram[roomIndex].listBed ?? []).isNotEmpty ? GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 7,
                      crossAxisSpacing: 7,
                      childAspectRatio: 4/3
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.diagram[roomIndex].listBed?.length ?? 0,
                    itemBuilder: (context, bedIndex) {
                      var status = state.diagram[roomIndex].listBed?[bedIndex].status;
                      bool isBedNotEmpty = status == 2;
                      bool isBedEmpty = status == 1 || status == null;

                      return WidgetPopupMenu(
                        name: "menu_bed_$roomIndex$bedIndex",
                        menu: [
                          if(isBedNotEmpty) WidgetMenuButton(
                            name: "Check - out",
                            icon: Icons.close,
                            onTap: () => controller.checkOut.perform(
                              idBed: state.diagram[roomIndex].listBed?[bedIndex].id,
                            )
                          ),
                          if(isBedNotEmpty) WidgetMenuButton(
                            name: "hủy Check - in",
                            icon: CupertinoIcons.delete,
                            onTap: () => controller.cancelBedOfDiagram.perform(
                              idBed: state.diagram[roomIndex].listBed?[bedIndex].id,
                              name: state.diagram[roomIndex].listBed?[bedIndex].name ?? "",
                            )
                          ),
                          if(isBedEmpty) WidgetMenuButton(
                            name: "Nhận khách lẻ",
                            icon: CupertinoIcons.add,
                            onTap: () => Navigator.pushNamed(context, OrderCreateInfoScreen.router, arguments: ToOrderCreateInfo(
                              type: OrderCreateInfoType.service,
                              bedData: state.diagram[roomIndex].listBed?[bedIndex]
                            ))
                          ),
                          if(isBedEmpty) WidgetMenuButton(
                            name: "Nhận khách liệu trình",
                            icon: CupertinoIcons.add,
                            // onTap: () => Navigator.pushNamed(context, OrderCreateInfoScreen.router, arguments: ToOrderCreateInfo(
                            //   type: OrderCreateInfoType.service,
                            //   bedData: state.diagram[roomIndex].listBed?[bedIndex]
                            // ))
                            onTap: () => Navigator.pushNamed(context, OrderScreen.router, arguments: 1),
                          ),
                          WidgetMenuButton(
                            name: "Sửa & cài đặt giường",
                            icon: Icons.edit,
                            onTap: () => controller.addEditBedOfDiagram.perform(
                              idRoom: state.diagram[roomIndex].id,
                              name: state.diagram[roomIndex].listBed?[bedIndex].name,
                              idBed: state.diagram[roomIndex].listBed?[bedIndex].id,
                            ),
                          ),
                          if(isBedEmpty) WidgetMenuButton(
                            name: "Xóa giường",
                            color: MyColor.red,
                            icon: CupertinoIcons.delete,
                            onTap: () => controller.deleteBedOfDiagram.perform(
                              idRoom: state.diagram[roomIndex].listBed?[bedIndex].id,
                              name: state.diagram[roomIndex].listBed?[bedIndex].name ?? "",
                            )
                          ),
                        ],
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: isBedNotEmpty ? MyColor.red.o7 : MyColor.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Center(child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(state.diagram[roomIndex].listBed?[bedIndex].name ?? "", style: TextStyles.def.bold.colors(
                                    isBedNotEmpty ? MyColor.white : MyColor.darkNavy
                                  ))
                                ],
                              )),
                              Positioned(
                                right: 10,
                                top: 6,
                                child: Text(isBedNotEmpty ? "Đã sử dụng" : "Đang trống", style: TextStyles.def.bold.colors(
                                  isBedNotEmpty ? MyColor.white : MyColor.green
                                ).size(10))
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ) : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Center(
                      child: Text("Không có giường nào cho ${state.diagram[roomIndex].name ?? ""}",
                        style: TextStyles.def.colors(MyColor.hideText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      );
    }
  }
}