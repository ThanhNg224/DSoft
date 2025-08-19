import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_group_staff.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_item/staff_item_controller.dart';

class StaffItemScreen extends BaseView<StaffItemController> {
  static const String router = "/StaffItemScreen";
  const StaffItemScreen({super.key});

  @override
  StaffItemController createController(BuildContext context)
  => StaffItemController(context);

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
                Utilities.retryButton(() => controller.getListStaff()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(
          builder: (context, state) {
            return WidgetListView(
                onRefresh: () async => controller.getListStaff(),
                children: [
                  WidgetBoxColor(
                    closed: ClosedEnd.start,
                    child: WidgetToolSearch(
                      controller: controller.staffController.cNameStaff,
                      isLoading: state.isLoadingSearch,
                      filter: BlocProvider.value(
                        value: controller.onTriggerEvent<StaffBloc>(),
                        child: BlocBuilder<StaffBloc, StaffState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                WidgetInput(
                                  title: "Số điện thoại",
                                  controller: controller.cPhone,
                                  hintText: "Nhập số điện thoại nhân viên",
                                ),
                                WidgetInput(
                                  title: "Email",
                                  controller: controller.cEmail,
                                  hintText: "Nhập số email nhân viên",
                                ),
                                WidgetDropDow<Data>(
                                  title: "Chọn nhóm",
                                  topTitle: "Nhóm nhân viên",
                                  content: state.listGroup.map((item) => WidgetDropSpan(value: item)).toList(),
                                  getValue: (item) => item.name ?? "",
                                  value: state.choseGroup,
                                  onSelect: (item) => context.read<StaffBloc>().add(SetChoseGroupStaffEvent(item)),
                                )
                              ],
                            );
                          }
                        ),
                      ),
                      onFilter: () => controller.getListStaff(state: state),
                      onChangeSearch: (_)=> controller.getListStaff(),
                    ),
                  ),
                  if(state.listStaff.isEmpty && !state.isLoadingSearch)
                    WidgetBoxColor(
                        closedBot: ClosedEnd.end,
                        child: Utilities.listEmpty()
                    )
                  else ..._list(state)
                ]
            );
          }
      );
    }
  }

  List<Widget> _list(StaffState state) => [
    WidgetBoxColor(
      closedBot: state.isLoadingSearch ? ClosedEnd.end : null,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 10),
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: MyColor.sliver,
              borderRadius: BorderRadius.circular(13)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(children: [
              Expanded(child: Text("Thông tin", style: TextStyles.def.bold.colors(MyColor.slateGray))),
              Text("Trạng thái", style: TextStyles.def.bold.colors(MyColor.slateGray)),
            ]),
          ),
        ),
      ),
    ),
    ...List.generate(state.listStaff.length, (index) {
      return WidgetBoxColor(
        closedBot: index == state.listStaff.length - 1 ? ClosedEnd.end : null,
        child: WidgetPopupMenu(
          name: "option_staff_$index",
          menu: [
            WidgetMenuButton(
                name: "Thông tin nhân viên",
                icon: CupertinoIcons.info,
                onTap: ()=> controller.toAddStaff(idStaff: state.listStaff[index].id)
            ),
            WidgetMenuButton(
                name: state.listStaff[index].status == 1 ? "Khóa tài khoản" : "Mở khóa",
                color: state.listStaff[index].status == 1 ? MyColor.red : MyColor.slateBlue,
                icon: state.listStaff[index].status == 1 ? CupertinoIcons.lock : CupertinoIcons.lock_open,
                onTap: ()=> controller.onLockStaff(
                  status: state.listStaff[index].status == 1 ? 0 : 1,
                  name: state.listStaff[index].name,
                  id: state.listStaff[index].id,
                )
            ),
          ],
          child: Material(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                WidgetAvatar(
                  url: state.listStaff[index].avatar,
                  size: 40,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.listStaff[index].name ?? "Đang cập nhật",
                          style: TextStyles.def.semiBold.size(15),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                        Text(state.listStaff[index].phone ?? "Đang cập nhật",
                          style: TextStyles.def.size(13).colors(MyColor.slateGray),
                          maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Text(StatusAccountStaff.title(state.listStaff[index].status), style: TextStyles.def.bold.colors(
                    StatusAccountStaff.color(state.listStaff[index].status)
                ).size(10))
              ]),
            ),
          ),
        ),
      );
    })
  ];
}