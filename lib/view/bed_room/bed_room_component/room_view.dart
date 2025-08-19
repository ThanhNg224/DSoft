import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/bed_room/bed_room_controller.dart';
import 'package:spa_project/view/bed_room/bloc/bed_room_bloc.dart';

mixin RoomView {
  BedRoomController get controller;
  BuildContext get context;

  Widget roomView(BedRoomState state) {
    return WidgetListView(
        onRefresh: () async => controller.onGetMultiple(false),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        children: [
          WidgetBoxColor(closed: ClosedEnd.start, child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: MyColor.sliver),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(children: [
                Expanded(child: Text("Tên phòng", style: TextStyles.def.bold.colors(MyColor.slateGray))),
                const SizedBox(width: 10),
                Text("Số giường", style: TextStyles.def.bold.colors(MyColor.slateGray)),
              ]),
            ),
          )),
          if(state.listRoom.isEmpty) WidgetBoxColor(
            closedBot: ClosedEnd.end,
            child: Utilities.listEmpty()
          )
          else ...List.generate(state.listRoom.length, (index) {
            return WidgetBoxColor(
              closedBot: index == state.listRoom.length - 1 ? ClosedEnd.end : null,
              child: WidgetPopupMenu(
                name: "popup_room_$index",
                menu: [
                  WidgetMenuButton(
                      name: "Sửa phòng",
                      icon: Icons.edit,
                      onTap: () {
                        AddEditRoomOfBedRoom(controller).perform(
                          id: state.listRoom[index].id,
                          name: state.listRoom[index].name,
                        );
                      }),
                  WidgetMenuButton(
                      name: "Xem giường",
                      icon: Icons.bedroom_child,
                      onTap: () => controller.onViewBed(state.listRoom[index].id)
                  ),
                  WidgetMenuButton(
                      name: "Xóa phòng",
                      icon: Icons.delete,
                      color: MyColor.red,
                      onTap: () => controller.onDeleteRoom(state.listRoom[index].id, state.listRoom[index].name)
                  ),
                ],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ColoredBox(
                    color: MyColor.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: Row(children: [
                        Expanded(
                          child: Text(state.listRoom[index].name ?? "", style: TextStyles.def.bold
                              .colors(MyColor.slateGray)),
                        ),
                        Text((state.listRoom[index].bed ?? 0).toString(), style: TextStyles.def.bold
                            .colors(MyColor.slateGray))
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
}