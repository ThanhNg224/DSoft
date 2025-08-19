import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/staff/staff_bonus/staff_bonus_controller.dart';
import 'package:spa_project/view/staff/staff_controller.dart';

import '../bloc/staff_bloc.dart';

class StaffBonusScreen extends BaseView<StaffBonusController> {
  const StaffBonusScreen({super.key});

  @override
  StaffBonusController createController(BuildContext context)
  => StaffBonusController(context);

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
                Utilities.retryButton(() => controller.onGetListBonus()),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<StaffBloc, StaffState>(
        builder: (context, state) {
          if(state.listBonus.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.onGetListBonus(),
              children: [Utilities.listEmpty()]
            );
          } else {
            return WidgetListView.builder(
              onRefresh: () async => controller.onGetListBonus(),
              itemCount: state.listBonus.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: WidgetPopupMenu(
                    name: "popup_item_bonus_$index",
                    realHeight: true,
                    menu: [
                      WidgetMenuButton(
                        name: state.listBonus[index].status == "new" ? "Sửa thưởng nhân viên" : "Xem thông tin",
                        icon: state.listBonus[index].status == "new" ? Icons.edit : CupertinoIcons.eye,
                        onTap: ()=> findController<StaffController>().toAddBonus(model: state.listBonus[index]),
                      ),
                      if(state.listBonus[index].status == "new") WidgetMenuButton(
                        name: "Thanh toán",
                        icon: Icons.payment,
                        onTap: ()=> controller.onOpenPayment(
                          name: state.listBonus[index].infoStaff?.name,
                          phone: state.listBonus[index].infoStaff?.phone,
                          bonus: state.listBonus[index].money
                        ),
                      )
                    ],
                    child: WidgetBoxColor(
                      closedBot: ClosedEnd.end,
                      closed: ClosedEnd.start,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(state.listBonus[index].infoStaff?.name ?? "Đang cập nhật",
                                  style: TextStyles.def.semiBold.size(15),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(state.listBonus[index].createdAt?.formatUnixToHHMMYYHHMM() ?? "Đang cập nhật",
                                style: TextStyles.def.semiBold.colors(MyColor.hideText).size(10),
                                maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Tiền thưởng: ${state.listBonus[index].money?.toCurrency(suffix: "đ") ?? "Đang cập nhật"}",
                                  style: TextStyles.def.colors(MyColor.slateGray).bold.size(12),
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(state.listBonus[index].status == "new" ? "Chưa thanh toán" : "Đã thanh toán",
                                  style: TextStyles.def.colors(state.listBonus[index].status == "new" ? MyColor.red : MyColor.green)
                                      .size(12).bold)
                            ],
                          ),
                          if((state.listBonus[index].note ?? "").isNotEmpty) Text("Nội dung:", style: TextStyles.def.semiBold.size(15)),
                          if((state.listBonus[index].note ?? "").isNotEmpty) Text(state.listBonus[index].note ?? "Đang cập nhật",
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