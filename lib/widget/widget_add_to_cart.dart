import 'dart:ui';

import 'package:spa_project/base_project/package.dart';

class WidgetAddToCart extends StatefulWidget {
  final Widget Function(AnimationWrapper animation) builder;

  const WidgetAddToCart({super.key, required this.builder});

  @override
  State<WidgetAddToCart> createState() => _WidgetAddToCartState();
}

class _WidgetAddToCartState extends State<WidgetAddToCart> with TickerProviderStateMixin {
  final GlobalKey _endKey = GlobalKey();
  final List<_FlyingItem> _flyingItems = [];
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
  }

  void _startAnimation(GlobalKey itemKey, Widget child, VoidCallback call) async {
    final renderStart = itemKey.currentContext?.findRenderObject() as RenderBox?;
    final renderEnd = _endKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.of(context);

    if (renderStart == null || renderEnd == null) return;

    final start = renderStart.localToGlobal(Offset.zero);
    final end = renderEnd.localToGlobal(Offset.zero);
    final width = renderStart.size.width;
    final height = renderStart.size.height;

    final controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    final animation = Tween<Offset>(
      begin: start,
      end: end,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

    final overlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: controller,
          builder: (_, __) {
            final offset = animation.value;
            final progress = controller.value;
            final scale = lerpDouble(1.0, 0.1, progress)!;
            final blur = lerpDouble(0.0, 20.0, progress)!;

            return Positioned(
              left: offset.dx,
              top: offset.dy,
              child: IgnorePointer(
                child: Transform.scale(
                  scale: scale,
                  alignment: Alignment.topLeft,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: blur,
                      sigmaY: blur,
                      tileMode: TileMode.decal,
                    ),
                    child: SizedBox(
                      width: width,
                      height: height,
                      child: child,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    overlay.insert(overlayEntry);
    controller.forward().then((_) {
      controller.dispose();
      overlayEntry.remove();
      call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final animation = AnimationWrapper(
      start: ({required Widget item, required VoidCallback call}) {
        final key = GlobalKey();
        return GestureDetector(
          key: key,
          onTap: () => _startAnimation(key, item, call),
          child: item,
        );
      },
      end: (child) => SizedBox(key: _endKey, child: child),
    );


    return Material(
      color: MyColor.nowhere,
      child: Stack(
        children: [
          widget.builder(animation),
          ..._flyingItems.map((item) {
            return AnimatedBuilder(
              animation: item.controller,
              builder: (_, __) {
                final offset = item.animation.value;
                final progress = item.controller.value;
                final scale = lerpDouble(1.0, 0.1, progress)!;
                final blur = lerpDouble(0.0, 20.0, progress)!;

                return Positioned(
                  left: offset.dx,
                  top: offset.dy,
                  child: IgnorePointer(
                    child: Transform.scale(
                      scale: scale,
                      alignment: Alignment.topLeft,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(
                          sigmaX: blur,
                          sigmaY: blur,
                          tileMode: TileMode.decal,
                        ),
                        child: SizedBox(
                          width: item.width,
                          height: item.height,
                          child: item.child,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          })
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class AnimationWrapper {
  final Widget Function({required Widget item, required VoidCallback call}) start;
  final Widget Function(Widget child) end;

  AnimationWrapper({required this.start, required this.end});
}

class _FlyingItem {
  final Widget child;
  final Animation<Offset> animation;
  final double width;
  final double height;
  final AnimationController controller;

  _FlyingItem({
    required this.child,
    required this.animation,
    required this.width,
    required this.height,
    required this.controller,
  });
}



