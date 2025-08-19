import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/service/bloc/service_bloc.dart';
import 'package:spa_project/view/service/service_conponent/service_group_view.dart';
import 'package:spa_project/view/service/service_conponent/service_view.dart';
import 'package:spa_project/view/service/service_controller.dart';

class ServiceScreen extends BaseView<ServiceController> with ServiceView, ServiceGroupView {
  static const String router = '/ServiceScreen';
  const ServiceScreen({super.key});

  @override
  ServiceController createController(BuildContext context)
  => ServiceController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ServiceBloc, ServiceState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(
              title: "Dịch vụ",
              actionIcon: WidgetButton(
                iconLeading: Icons.add,
                vertical: 0,
                horizontal: 10,
                onTap: ()=> state.pageIndex == 1
                    ? controller.addEdit.perform()
                    : controller.onToAddEditService()
              ),
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: Utilities.defaultScroll,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(children: [
                      WidgetButton(
                        title: "Dịch vụ",
                        color: state.pageIndex == 0 ? MyColor.green : MyColor.sliver,
                        horizontal: 20,
                        vertical: 7,
                        onTap: () {
                          context.read<ServiceBloc>().add(SetPageViewServiceEvent(0));
                        },
                      ),
                      const SizedBox(width: 20),
                      WidgetButton(
                        title: "Nhóm dịch vụ",
                        horizontal: 20,
                        vertical: 7,
                        color: state.pageIndex == 1 ? MyColor.green : MyColor.sliver,
                        onTap: () {
                          context.read<ServiceBloc>().add(SetPageViewServiceEvent(1));
                        },
                      ),
                    ]),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(child: _body(state)),
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _body(ServiceState state) {
    if(controller.screenStateIsLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: WidgetShimmer(
          radius: 20,
          width: double.infinity,
        ),
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
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.onGetMulti(true)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return _list(state)[state.pageIndex];
    }
  }

  List<Widget> _list(ServiceState state) => [
    serviceView(state),
    serviceGroupView(state),
  ];
}