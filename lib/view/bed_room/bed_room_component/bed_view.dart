import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/bed_room/bed_room_controller.dart';
import 'package:spa_project/view/bed_room/bloc/bed_room_bloc.dart';

mixin BedView {
  BedRoomController get controller;
  BuildContext get context;

  Widget bedView(BedRoomState state) {
    return WidgetListView(
        onRefresh: () async => controller.onGetMultiple(false),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
        children: [
          WidgetBoxColor(closed: ClosedEnd.start, child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyColor.sliver),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(children: [
                Expanded(child: Text("Giường", style: TextStyles.def.bold.colors(MyColor.slateGray))),
                const SizedBox(width: 10),
                Text("Phòng", style: TextStyles.def.bold.colors(MyColor.slateGray)),
              ]),
            ),
          )),
          if(state.listBed.isEmpty) WidgetBoxColor(
              closedBot: ClosedEnd.end,
              child: Utilities.listEmpty()
          )
          else ...List.generate(state.listBed.length, (index) {
            return WidgetBoxColor(
                closedBot: index == state.listBed.length - 1 ? ClosedEnd.end : null,
                child: WidgetPopupMenu(
                  name: "popup_bed_$index",
                  menu: [
                    WidgetMenuButton(
                        name: "Sửa giường",
                        icon: Icons.edit,
                        onTap: () {
                          AddEditBedOfBedRoom(context).perform(
                            state: state,
                            id: state.listBed[index].id,
                            index: index
                          );
                        }),
                    WidgetMenuButton(
                        name: "xóa giường",
                        icon: Icons.delete,
                        color: MyColor.red,
                        onTap: () => controller.onDeleteBed(state.listBed[index].id, state.listBed[index].name)
                    )
                  ],
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColoredBox(
                        color: MyColor.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                          child: Row(children: [
                            Expanded(
                              child: Text(state.listBed[index].name ?? "", style: TextStyles.def.bold
                                  .colors(MyColor.slateGray)),
                            ),
                            Text(state.listBed[index].room?.name ?? "", style: TextStyles.def.bold
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