import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/service/bloc/service_bloc.dart';
import 'package:spa_project/view/service/service_controller.dart';

mixin ServiceGroupView {
  ServiceController get controller;
  BuildContext get context;

  Widget serviceGroupView(ServiceState state) {
    return WidgetListView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
      onRefresh: () async => controller.getListCate.perform(),
        controller: controller.scrollController,
      children: [
        WidgetBoxColor(closed: ClosedEnd.start, child: DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: MyColor.sliver),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(children: [
              SizedBox(
                width: 50,
                child: Text("ID", style: TextStyles.def.bold.colors(MyColor.slateGray))
              ),
              const SizedBox(width: 10),
              Text("Tên nhóm", style: TextStyles.def.bold.colors(MyColor.slateGray)),
            ]),
          ),
        )),
        if(state.listCate.isEmpty) WidgetBoxColor(
            closedBot: ClosedEnd.end,
            child: Utilities.listEmpty()
        )
        else ...List.generate(state.listCate.length, (index) {
          return WidgetBoxColor(
              closedBot: index == state.listCate.length - 1 ? ClosedEnd.end : null,
              child: WidgetPopupMenu(
                name: "popup_cate_$index",
                menu: [
                  WidgetMenuButton(
                      name: "Sửa nhóm dịch vụ",
                      icon: Icons.edit,
                      onTap: () {
                        controller.addEdit.perform(
                          id: state.listCate[index].id,
                          name: state.listCate[index].name,
                        );
                      }),
                  WidgetMenuButton(
                      name: "Xóa nhóm dịch vụ",
                      icon: Icons.delete,
                      color: MyColor.red,
                      onTap: () => controller.onDeleteCateService(state.listCate[index].id)
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
                            child: Text("${state.listCate[index].id ?? 0}", style: TextStyles.def.bold
                                .colors(MyColor.slateGray)),
                          ),
                          Expanded(
                            child: Text(state.listCate[index].name ?? "", style: TextStyles.def.bold
                                .colors(MyColor.slateGray)),
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
}