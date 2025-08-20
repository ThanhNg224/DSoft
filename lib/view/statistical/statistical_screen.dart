import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/statistical/statistical_commission/statistical_agency_screen.dart';
import 'package:spa_project/view/statistical/statistical_controller.dart';
import 'package:spa_project/view/statistical/statistical_cubit.dart';
import 'package:spa_project/view/statistical/statistical_service/statistical_service_screen.dart';


class StatisticalScreen extends BaseView<StatisticalController> {
  static const String router = "/StatisticalScreen";
  const StatisticalScreen({super.key});

  @override
  StatisticalController createController(BuildContext context)
  => StatisticalController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(title: "Thông kê sử dụng dịch vụ"),
      body: BlocBuilder<StatisticalCubit, StatisticalState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: Utilities.defaultScroll,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    WidgetButton(
                      title: "Dịch vụ thẻ tháng",
                      color: state.indexPage == 0 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () {
                        context.read<StatisticalCubit>().setPageIndexStatisticalEvent(0);
                      },
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Hoa hồng nhân viên",
                      horizontal: 20,
                      vertical: 7,
                      color: state.indexPage == 1 ? MyColor.green : MyColor.sliver,
                      onTap: () {
                        context.read<StatisticalCubit>().setPageIndexStatisticalEvent(1);
                      },
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _body(state)),
            ],
          );
        }
      ),
    );
  }

  Widget _body(StatisticalState state) {
    double totalValue = state.listStatisticalService.fold(0.0, (sum, item) => sum + (item.value as num).toDouble());
    return IndexedStack(
      index: state.indexPage,
      children: const [
        StatisticalServiceScreen(),
        StatisticalAgencyScreen()
      ],
    );
  }



}