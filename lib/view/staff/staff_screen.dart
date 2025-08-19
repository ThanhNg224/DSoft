import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_bonus/staff_bonus_screen.dart';
import 'package:spa_project/view/staff/staff_controller.dart';
import 'package:spa_project/view/staff/staff_group/staff_group_controller.dart';
import 'package:spa_project/view/staff/staff_group/staff_group_screen.dart';
import 'package:spa_project/view/staff/staff_item/staff_item_screen.dart';
import 'package:spa_project/view/staff/staff_punish/staff_punish_screen.dart';
import 'package:spa_project/view/staff/staff_time_sheet/staff_time_sheet_screen.dart';
import 'package:spa_project/view/staff/staff_wage/staff_wage_screen.dart';

class StaffScreen extends BaseView<StaffController> {
  static const String router = "StaffScreen";
  const StaffScreen({super.key});

  @override
  StaffController createController(BuildContext context)
  => StaffController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<StaffBloc, StaffState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => Utilities.dismissKeyboard(),
          child: DefaultTabController(
            length: _listPageView().length,
            child: Scaffold(
              backgroundColor: MyColor.softWhite,
              appBar: WidgetAppBar(
                title: "Nhân viên",
                actionIcon: WidgetButton(
                  title: "",
                  iconLeading: Icons.add,
                  onTap: () {
                    if (state.indexPage == 0) {
                      controller.toAddStaff();
                    } else if(state.indexPage == 1) {
                      findController<StaffGroupController>().openAddEdit();
                    } else if(state.indexPage == 2) {
                      controller.toAddBonus();
                    } else if(state.indexPage == 3) {
                      controller.toAddBonus(isBonus: false);
                    } else if(state.indexPage == 4) {
                      controller.onOpenCheckTimeSheet();
                    } else if(state.indexPage == 5) {
                      controller.toAddWage();
                    }
                  },
                  vertical: 0,
                  horizontal: 10,
                ),
              ),
              body: Builder(
                builder: (context) {
                  final tabController = DefaultTabController.of(context);
                  final selectedIndex = tabController.index;

                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      TabBar(
                        dividerColor: MyColor.nowhere,
                        onTap: (index) => context.read<StaffBloc>().add(ChosePageViewStaffEvent(index)),
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: MyColor.slateBlue.o3,
                        ),
                        labelColor: MyColor.slateBlue,
                        unselectedLabelColor: MyColor.slateGray,
                        indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        padding: const EdgeInsets.only(right: 20),
                        tabs: [
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.person),
                              Text("Nhân viên", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 0 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.group),
                              Text("Nhóm nhân viên", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 1 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.emoji_events),
                              Text("Thưởng nhân viên", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 2 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.dangerous),
                              Text("Phạt nhân viên", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 3 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.fact_check),
                              Text("Chấm công", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 4 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                          Tab(child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.savings),
                              Text("Bảng lương", style: TextStyles.def.size(10).bold.colors(selectedIndex  == 5 ? MyColor.slateBlue : MyColor.slateGray)),
                            ],
                          )),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: _listPageView()
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _listPageView() => [
    const StaffItemScreen(),
    const StaffGroupScreen(),
    const StaffBonusScreen(),
    const StaffPunishScreen(),
    const StaffTimeSheetScreen(),
    const StaffWageScreen(),
  ];

}