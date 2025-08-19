

import 'package:spa_project/base_project/package.dart';

class WidgetLoading extends StatefulWidget {
  final Color? color;
  const WidgetLoading({
    super.key,
    this.color = MyColor.slateBlue
  });

  @override
  State<WidgetLoading> createState() => _WidgetLoadingState();
}

class _WidgetLoadingState extends State<WidgetLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();

    _animations = List.generate(3, (index) {
      return TweenSequence<double>([
        TweenSequenceItem(tween: Tween(begin: 0, end: -10), weight: 50),
        TweenSequenceItem(tween: Tween(begin: -10, end: 0), weight: 50),
      ]).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(index * 0.2, 1.0, curve: Curves.easeInOut),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animations[index].value),
                child: child,
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
