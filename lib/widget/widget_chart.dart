import 'dart:math';

import 'package:spa_project/base_project/package.dart';

class WidgetChart extends StatelessWidget {
  final List<WidgetChartItem> list;
  final double aspectRatio;

  const WidgetChart({
    super.key,
    required this.list,
    this.aspectRatio = 1,
  });

  List<double> generateChartMarkers(List<WidgetChartItem> list) {
    List<double> values = list.map((e) => e.value).toList();
    double maxVal = values.reduce((a, b) => a > b ? a : b);
    double minVal = values.reduce((a, b) => a < b ? a : b);
    if (maxVal == minVal) return List.filled(5, maxVal);
    double step = (maxVal - minVal) / 4;
    List<double> markers = List.generate(5, (index) => maxVal - (step * index));
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetChartCubit, int>(
      builder: (context, ind) {
        return Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: MyColor.borderInput, width: 1.5)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(children: [
                  Expanded(child: Text(list[ind].time.formatUnixTimeToMonthYear())),
                  const Icon(Icons.calendar_today_outlined, size: 18)
                ]),
              ),
            ),
            const SizedBox(height: 17),
            AspectRatio(
              aspectRatio: aspectRatio,
              child: Row(
                children: [
                  Column(
                    children: generateChartMarkers(list).map((value) {
                      return Expanded(
                        child: Text(
                          (value.toDouble()).formatNumberShort(),
                          style: TextStyles.def.colors(MyColor.hideText)
                        ),
                      );
                    }).toList(),
                  ),
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double fullWidth = constraints.maxWidth;
                        double itemWidth = 44;
                        double chartHeight = constraints.maxHeight;

                        Widget chartContent = Stack(
                          children: [
                            Positioned.fill(
                              child: TweenAnimationBuilder<double>(
                                tween: Tween<double>(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 2000),
                                curve: Curves.easeOutExpo,
                                builder: (context, animationValue, _) {
                                  return Transform.scale(
                                    alignment: Alignment.bottomCenter,
                                    scaleY: animationValue,
                                    child: CustomPaint(
                                      painter: LineChartPainter(list, chartHeight, indexSelected: ind),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(list.length, (index) {
                                return GestureDetector(
                                  onTap: ()=> context.read<WidgetChartCubit>().onSelect(index),
                                  child: SizedBox(
                                    width: itemWidth,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: ColoredBox(
                                                color: ind == index ? MyColor.slateBlue.o1 : MyColor.nowhere,
                                                child: Column(children: List.generate((fullWidth / 10).round(), (indexDos) {
                                                  return Expanded(
                                                    child: SizedBox(
                                                        width: 1.5,
                                                        child: ind == index
                                                            ? ColoredBox(color: indexDos % 2 == 0 ? MyColor.slateBlue.o2 : MyColor.nowhere)
                                                            : const SizedBox()
                                                    ),
                                                  );
                                                })),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text("${index + 1}", style: TextStyles.def.colors(MyColor.hideText)),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        );

                        // Nếu dữ liệu vượt quá màn hình thì cho cuộn ngang
                        if (fullWidth < list.length * itemWidth) {
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: list.length * itemWidth,
                              height: chartHeight,
                              child: chartContent,
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: fullWidth,
                            height: chartHeight,
                            child: chartContent,
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: 20),
            DecoratedBox(
              decoration: BoxDecoration(
                color: MyColor.green,
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 18),
                child: Row(children: [
                  Expanded(
                    child: Text(list[ind].time.formatUnixTimeToWeekday(), style: TextStyles.def.colors(MyColor.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ),
                  Expanded(
                    child: Text(list[ind].value.formatNumberShort(), style: TextStyles.def.bold.colors(MyColor.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    )
                  ),
                ]),
              ),
            )
          ],
        );
      }
    );
  }
}

class WidgetChartItem {
  int time;
  double value;
  WidgetChartItem(this.value, this.time);
}

// class LineChartPainter extends CustomPainter {
//   final List<WidgetChartItem> list;
//   final double animationValue;
//   final int? indexSelected;
//
//   LineChartPainter(this.list, this.animationValue, {this.indexSelected});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     if (list.isEmpty) return;
//
//     double maxVal = list.map((e) => e.value).reduce(max);
//     double minVal = list.map((e) => e.value).reduce(min);
//     double rangePadding = (maxVal - minVal) * 0.18;
//     double displayMin = minVal - rangePadding;
//     if (displayMin > 0) displayMin = 0;
//
//     double normalize(double value) {
//       if (maxVal == minVal) return animationValue / 2;
//       return ((maxVal - value) / (maxVal - displayMin)) * animationValue;
//     }
//
//     Paint paintLine = Paint()
//       ..color = MyColor.slateBlue
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke;
//
//     Paint paintDot = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//
//     double itemWidth = 44;
//     for (int i = 0; i < list.length; i++) {
//       double x = i * itemWidth + itemWidth / 2;
//       double y = normalize(list[i].value);
//
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//
//       if (indexSelected == i) {
//         canvas.drawCircle(Offset(x, y), 4, paintDot);
//       }
//     }
//     canvas.drawPath(path, paintLine);
//   }
//
//   @override
//   bool shouldRepaint(covariant LineChartPainter oldDelegate) {
//     return oldDelegate.animationValue != animationValue || oldDelegate.indexSelected != indexSelected;
//   }
// }

class LineChartPainter extends CustomPainter {
  final List<WidgetChartItem> list;
  final double animationValue;
  final int? indexSelected;

  LineChartPainter(this.list, this.animationValue, {this.indexSelected});

  @override
  void paint(Canvas canvas, Size size) {
    if (list.isEmpty) return;

    double maxVal = list.map((e) => e.value).reduce(max);
    double minVal = list.map((e) => e.value).reduce(min);
    double rangePadding = (maxVal - minVal) * 0.18;
    double displayMin = minVal - rangePadding;
    if (displayMin > 0) displayMin = 0;

    double normalize(double value) {
      if (maxVal == minVal) return animationValue / 2;
      return ((maxVal - value) / (maxVal - displayMin)) * animationValue;
    }

    Paint paintLine = Paint()
      ..color = MyColor.slateBlue
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;
    Paint paintDot = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    Path path = Path();

    double itemWidth = 44;

    if (list.isNotEmpty) {
      double firstX = 0 * itemWidth + itemWidth / 2;
      double firstY = normalize(list[0].value);
      path.moveTo(firstX, firstY);
    }

    for (int i = 1; i < list.length; i++) {
      double prevX = (i - 1) * itemWidth + itemWidth / 2;
      double prevY = normalize(list[i - 1].value);
      double x = i * itemWidth + itemWidth / 2;
      double y = normalize(list[i].value);

      double controlPoint1X = prevX + (x - prevX) * 0.3;
      double controlPoint1Y = prevY;
      double controlPoint2X = x - (x - prevX) * 0.3;
      double controlPoint2Y = y;

      path.cubicTo(
          controlPoint1X, controlPoint1Y,
          controlPoint2X, controlPoint2Y,
          x, y
      );
      if (indexSelected == i) canvas.drawCircle(Offset(x, y), 4, paintDot);
    }
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant LineChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.indexSelected != indexSelected;
  }
}

class WidgetChartCubit extends Cubit<int> {
  WidgetChartCubit() : super(0);

  void onSelect(int index) => emit(index);
}
