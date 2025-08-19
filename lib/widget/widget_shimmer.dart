import 'package:spa_project/base_project/package.dart';

class WidgetShimmer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double radius;

  const WidgetShimmer({
    super.key,
    this.width = 100,
    this.height = 20,
    this.color = MyColor.sliver,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetShimmerCubit, bool>(
      builder: (context, visible) {
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 500),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        );
      },
    );
  }
}

class WidgetShimmerCubit extends Cubit<bool> {
  WidgetShimmerCubit() : super(true) {
    _startBlink();
  }

  void _startBlink() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(!state);
      return true;
    });
  }
}

