import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_group/staff_group_controller.dart';

class StaffGroupScreen extends BaseView<StaffGroupController> {
  static const String router = "/StaffGroupScreen";
  const StaffGroupScreen({super.key});

  @override
  StaffGroupController createController(BuildContext context)
  => StaffGroupController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return const Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: WidgetShimmer(width: double.infinity, radius: 20, height: 200),
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                Utilities.retryButton(() => controller.onGetListGroup()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(builder: (context, state) {
        return WidgetListView(onRefresh: () async => controller.onGetListGroup(), children: [
          WidgetBoxColor(closed: ClosedEnd.start, child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: MyColor.sliver),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(children: [
                SizedBox(
                    width: 40,
                    child: Text("ID", style: TextStyles.def.bold.colors(MyColor.slateGray))
                ),
                const SizedBox(width: 10),
                Expanded(child: Text("Nhóm nhân viên", style: TextStyles.def.bold.colors(MyColor.slateGray))),
              ]),
            ),
          )),
          if(state.listGroup.isEmpty) WidgetBoxColor(
              closedBot: ClosedEnd.end,
              child: WidgetListView(
                onRefresh: () async => controller.onGetListGroup(),
                children: [Utilities.listEmpty()]
              )
          )
          else ...List.generate(state.listGroup.length, (index) {
            return WidgetBoxColor(
                closedBot: index == state.listGroup.length - 1 ? ClosedEnd.end : null,
                child: WidgetPopupMenu(
                  name: "popup_group_staff_$index",
                  menu: [
                    WidgetMenuButton(
                        name: "Sửa nhóm nhân viên",
                        icon: Icons.edit,
                        onTap: () {
                          controller.openAddEdit(
                              id: state.listGroup[index].id,
                              name: state.listGroup[index].name
                          );
                        }),
                    WidgetMenuButton(
                        name: "Xóa nhóm",
                        icon: Icons.delete,
                        color: MyColor.red,
                        onTap: () => controller.deleteGroupStaff(state.listGroup[index].id)
                    )
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: MyColor.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Row(children: [
                          SizedBox(
                              width: 40,
                              child: Text(
                                  (state.listGroup[index].id ?? 0).toString(),
                                  style: TextStyles.def.bold
                                      .colors(MyColor.slateGray))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(state.listGroup[index].name ?? "",
                                  style: TextStyles.def.bold
                                      .colors(MyColor.slateGray))),
                        ]),
                      ),
                    ),
                  ),
                ));
          })
        ]);
      });

    }
  }
}