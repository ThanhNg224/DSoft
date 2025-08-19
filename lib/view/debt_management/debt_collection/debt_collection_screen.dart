import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/debt_management/debt_add_collection/debt_add_collection_screen.dart';
import 'package:spa_project/view/debt_management/debt_collection/debt_collection_controller.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';
import 'package:spa_project/view/debt_management/debt_management_screen.dart';

class DebtCollectionScreen extends BaseView<DebtCollectionController> {
  final DebtManagementState state;
  const DebtCollectionScreen({super.key, required this.state});

  @override
  DebtCollectionController createController(BuildContext context)
  => DebtCollectionController(context);

  @override
  Widget zBuild() {
    return ColoredBox(
      color: MyColor.softWhite,
      child: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              height: 180,
              width: double.infinity,
            ),
          );
        },
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
                Utilities.retryButton(() => controller.onGetDebtCollection()),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      if(state.listDebtCollection.isEmpty) {
        return WidgetListView(
          onRefresh: () async => controller.onGetDebtCollection(),
          children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView.builder(
        itemCount: state.listDebtCollection.length,
        onRefresh: () async => controller.onGetDebtCollection(isLoad: false),
        itemBuilder: (context, index) {
          bool isUnfinished = state.listDebtCollection[index].status == 0;

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, DebtAddCollectionScreen.router, arguments: DebtManagementSend(
              data: state.listDebtCollection[index]
            )),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: MyColor.darkNavy.o1,
                      blurRadius: 10,
                      offset: const Offset(0, 2)
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "THU NỢ",
                          style: TextStyles.def.size(12).colors(MyColor.hideText).bold,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: isUnfinished
                                ? MyColor.red.o1
                                : MyColor.green.o1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            isUnfinished ? "Chưa trả" : "Đã trả",
                            style: TextStyles.def.size(11)
                                .colors(isUnfinished ? MyColor.red : MyColor.green)
                                .bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 18,
                            color: MyColor.slateGray),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.listDebtCollection[index].fullName ?? "Đang cập nhật",
                            style: TextStyles.def.size(15).colors(MyColor.slateGray).bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.badge_outlined,
                            size: 18,
                            color: MyColor.slateGray),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            state.listDebtCollection[index].staff?.name ?? "Đang cập nhật",
                            style: TextStyles.def.size(15).colors(MyColor.slateGray).bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.price_change_outlined,
                            size: 18,
                            color: MyColor.slateGray),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Số tiền: ${state.listDebtCollection[index].total?.toCurrency() ?? "Đang cập nhật"}",
                            style: TextStyles.def.size(15).colors(MyColor.slateGray).bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14,
                            color: MyColor.hideText),
                        const SizedBox(width: 4),
                        Text(
                          state.listDebtCollection[index].time
                              ?.formatUnixTimeToDateDDMMYYYY(format: "dd/MM/yyyy - HH:mm") ?? "",
                          style: TextStyles.def.size(11).colors(MyColor.hideText),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}