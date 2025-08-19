import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/statistical/statistical_cubit.dart';
import 'package:spa_project/view/statistical/statistical_service/statistical_service_controller.dart';

import '../../home/component_home.dart';

class StatisticalServiceScreen extends BaseView<StatisticalServiceController> {
  static const String router = "/StatisticalServiceScreen";
  const StatisticalServiceScreen({super.key});

  @override
  StatisticalServiceController createController(BuildContext context)
  => StatisticalServiceController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ComponentHome.loadBilStatistical(),
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              Utilities.retryButton(() => controller.onGetServiceMoth())
            ],
          ),
        )),
      );
    } else {
      return BlocBuilder<StatisticalCubit, StatisticalState>(
        builder: (context, state) {
          double totalValue = state.listStatisticalService.fold(0.0, (sum, item) => sum + (item.value as num).toDouble());
          return WidgetListView(
            onRefresh: () async => controller.onGetServiceMoth(isLoad: false),
            children: [
              WidgetBoxColor(
                closedBot: ClosedEnd.end,
                closed: ClosedEnd.start,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Tổng số lượng khách sử dụng dịch vụ: ",
                              style: TextStyles.def.size(16)
                          ),
                          TextSpan(
                              text: totalValue.round().toString(),
                              style: TextStyles.def.size(16).bold.colors(MyColor.slateBlue)
                          )
                        ]
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(children: [
                        const ClipOval(
                          child: SizedBox(
                            height: 10,
                            width: 10,
                            child: ColoredBox(color: MyColor.slateBlue),
                          ),
                        ),
                        Expanded(child: Text("  Biểu thị 1", style: TextStyles.def.size(10).bold))
                      ]),
                    ),
                    if(state.listStatisticalService.isNotEmpty)
                      WidgetChart(list: List.generate(state.listStatisticalService.length, (index) {
                        return WidgetChartItem(state.listStatisticalService[index].value ?? 0, state.listStatisticalService[index].time ?? 0);
                      }))
                    else Center(child: Utilities.listEmpty(content: "Không có dữ liệu"))
                  ],
                ),
              )
            ],
          );
        }
      );
    }
  }
}