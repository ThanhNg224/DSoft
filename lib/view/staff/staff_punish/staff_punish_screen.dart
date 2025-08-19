import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/bloc/staff_bloc.dart';
import 'package:spa_project/view/staff/staff_punish/staff_punish_controller.dart';

import '../staff_controller.dart';

class StaffPunishScreen extends BaseView<StaffPunishController> {
  const StaffPunishScreen({super.key});

  @override
  StaffPunishController createController(BuildContext context)
  => StaffPunishController(context);

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
                Utilities.retryButton(() => controller.onGetListPunish()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          if(state.listPunish.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.onGetListPunish(),
              children: [Utilities.listEmpty()]
            );
          } else {
            return WidgetListView.builder(
              onRefresh: () async => controller.onGetListPunish(),
              itemCount: state.listPunish.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: GestureDetector(
                    onTap: ()=> findController<StaffController>().toAddBonus(model: state.listPunish[index], isBonus: false),
                    child: WidgetBoxColor(
                        closedBot: ClosedEnd.end,
                        closed: ClosedEnd.start,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(state.listPunish[index].infoStaff?.name ?? "Đang cập nhật",
                                    style: TextStyles.def.semiBold.size(15),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(state.listPunish[index].createdAt?.formatUnixToHHMMYYHHMM() ?? "Đang cập nhật",
                                  style: TextStyles.def.semiBold.colors(MyColor.hideText).size(10),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Tiền thưởng: ${state.listPunish[index].money?.toCurrency(suffix: "đ") ?? "Đang cập nhật"}",
                                    style: TextStyles.def.colors(MyColor.slateGray).bold.size(12),
                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(state.listPunish[index].status == "new" ? "Chưa thanh toán" : "Đã thanh toán",
                                    style: TextStyles.def.colors(state.listPunish[index].status == "new" ? MyColor.red : MyColor.green)
                                        .size(12).bold)
                              ],
                            ),
                            if((state.listPunish[index].note ?? "").isNotEmpty) Text("Nội dung:", style: TextStyles.def.semiBold.size(15)),
                            if((state.listPunish[index].note ?? "").isNotEmpty) Text(state.listPunish[index].note ?? "Đang cập nhật",
                              style: TextStyles.def.colors(MyColor.slateGray).size(12),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    }
  }
}