import 'package:spa_project/base_project/package.dart';

class WidgetProgress extends StatelessWidget {
  final double value;
  const WidgetProgress({super.key,
    this.value = 0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double max = constraints.maxWidth - 4;
        double progress = (max / 100) * value;

        return Container(
          height: 10,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: MyColor.borderInput,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 400),
              tween: Tween<double>(begin: 0, end: progress),
              curve: Curves.fastEaseInToSlowEaseOut,
              builder: (context, aValue, _) {
                return SizedBox(
                  width: aValue,
                  height: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const ColoredBox(
                      color: MyColor.slateBlue
                    ),
                  )
                );
              },
            ),
          ),
        );
      },
    );
  }
}