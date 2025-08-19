import 'package:spa_project/base_project/package.dart';

class WidgetBoxColor extends StatelessWidget {
  final ClosedEnd? closed;
  final ClosedEnd? closedBot;
  final Color? color;
  final Widget child;
  const WidgetBoxColor({
    super.key, this.closed, required this.child, this.closedBot,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? MyColor.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(closed == ClosedEnd.start ? 20 : 0),
          bottom: Radius.circular(closedBot == ClosedEnd.end ? 20 : 0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: 20,
          left: 20,
          top: closed == null || closed == ClosedEnd.end ? 0 : 25,
          bottom: closedBot == ClosedEnd.end ? 25 : 10
        ),
        child: Center(child: child),
      )
    );
  }
}
