import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/multi_view/multi_view_controller.dart';

import 'bloc/multi_view_bloc.dart';

class MultiViewScreen extends BaseView<MultiViewController> {
  static const String router = "/MultiViewScreen";
  const MultiViewScreen({super.key});

  @override
  MultiViewController createController(BuildContext context) => MultiViewController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<MultiViewBloc, MultiViewState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Scaffold(
              key: MultiViewController.scaffoldKey,
              backgroundColor: MyColor.softWhite,
              drawer: controller.initDrawer(os.modelMyInfo?.data?.avatar),
              drawerScrimColor: MyColor.nowhere,
              body: IndexedStack(
                index: state.currentIndex,
                children: controller.screen(state.currentIndex),
              ),
              bottomNavigationBar: DecoratedBox(
                decoration: BoxDecoration(
                  color: MyColor.white,
                  boxShadow: [BoxShadow(
                    blurRadius: 10,
                    color: MyColor.darkNavy.o1
                  )]
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(children: [
                    _btnBottomBar(
                      text: "Trang chủ",
                      icon: state.currentIndex == 0 ? Icons.home : Icons.home_outlined,
                      themeColor: state.currentIndex == 0 ? MyColor.slateBlue : null,
                      onTap: () => controller.onChangePage(0),
                      scaleIcon: state.currentIndex == 0 ? 1.2 : 1.0
                    ),
                    _btnBottomBar(
                      text: "Khách hàng",
                      icon: state.currentIndex == 1 ? Icons.groups : Icons.groups_outlined,
                      themeColor: state.currentIndex == 1 ? MyColor.slateBlue : null,
                      onTap: () => controller.onChangePage(1),
                      scaleIcon: state.currentIndex == 1 ? 1.2 : 1.0
                    ),
                    _btnBottomBar(
                      text: "Lịch hẹn",
                      icon: state.currentIndex == 2 ? Icons.auto_awesome_mosaic : Icons.auto_awesome_mosaic_outlined,
                      themeColor: state.currentIndex == 2 ? MyColor.slateBlue : null,
                      onTap: () => controller.onChangePage(2),
                      scaleIcon: state.currentIndex == 2 ? 1.2 : 1.0
                    ),
                    _btnBottomBar(
                      text: "Cá nhân",
                      icon: state.currentIndex == 3 ? Icons.settings : Icons.settings_outlined,
                      themeColor: state.currentIndex == 3 ? MyColor.slateBlue : null,
                      onTap: () => controller.onChangePage(3),
                      scaleIcon: state.currentIndex == 3 ? 1.2 : 1.0
                    )
                  ]),
                )
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: controller.confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                numberOfParticles: 50,
                colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _btnBottomBar({
    required IconData icon,
    required String text,
    required Function() onTap,
    double scaleIcon = 1,
    Color? themeColor
  }) => Expanded(
    child: Material(
      color: (themeColor ?? MyColor.white).o2,
      borderRadius: BorderRadius.circular(100),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
                scale: scaleIcon,
                child: Icon(icon, color: themeColor ?? MyColor.slateGray)
              ),
              AutoSizeText(
                text, style: TextStyles.def.bold.colors(themeColor ?? MyColor.slateGray).size(12),
                maxLines: 1, overflow: TextOverflow.ellipsis,
                minFontSize: 10,
              )
            ],
          ),
        ),
      ),
    ),
  );

}
