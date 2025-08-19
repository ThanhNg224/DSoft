import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';

class WidgetPopupMenu extends StatelessWidget {
  final Widget child;
  final List<WidgetMenuButton> menu;
  final String name;
  final bool realHeight;
  WidgetPopupMenu({super.key,
    required this.child,
    required this.menu,
    required this.name,
    this.realHeight = false
  });

  final GlobalKey _kChild = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleBlur(),
      child: GestureDetector(
          onTap: ()=> _nextPage(context),
          child: Hero(
            tag: name,
            createRectTween: (begin, end) => _CustomRectTween(end: end!, begin: begin!),
            child: Material(
              key: _kChild,
              color: Colors.transparent, child: child
            )
          )
      ),
    );
  }

  void _nextPage(BuildContext context) {

    final RenderBox? renderBox = _kChild.currentContext?.findRenderObject() as RenderBox?;
    final Size childSize = renderBox?.size ?? Size.zero;
    context.read<ToggleBlur>().onRefresh();
    context.read<ToggleBlur>().toggle();
    Navigator.push(context, PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) => _Popup(
        tag: name,
        item: menu,
        size: childSize,
        realHeight: realHeight,
        child: child,
      ),
    )).whenComplete(() {
      if(context.mounted) context.read<ToggleBlur>().toggle();
    });
  }
}

class _Popup extends StatelessWidget {
  final Object tag;
  final Widget child;
  final List<WidgetMenuButton> item;
  final Size size;
  final bool realHeight;
  const _Popup({required this.tag, required this.item, required this.child, required this.size, this.realHeight = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BlocBuilder<ToggleBlur, bool>(
          builder: (context, isBlur) {
            return GestureDetector(
              onTap: ()=> Navigator.pop(context),
              child: Material(
                color: Colors.transparent,
                child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: isBlur ? 10 : 0),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) {
                      return BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: value, sigmaX: value),
                        child: ColoredBox(color: MyColor.darkNavy.withValues(alpha: value / 100)),
                      );
                    }
                ),
              ),
            );
          }
        ),
        Center(child: Material(color: Colors.transparent, child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
              children: [
                SizedBox(
                  width: min(size.width * 5, Utilities.screen(context).w * 0.8),
                  height: realHeight ? size.height : size.height * (min(size.width * 5, Utilities.screen(context).w * 0.8) / size.width),
                  child: Hero(
                    tag: tag,
                    child: Material(color: MyColor.nowhere, child: child)
                  ),
                ),
                const SizedBox(height: 13),
                _listButton(context)
              ],
            )
        ))),
      ],
    );
  }

  Widget _listButton(BuildContext context) {
    return BlocBuilder<ToggleBlur, bool>(
      builder: (context, isBlur) {
        return AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: isBlur ? 1 : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: List.generate(item.length, (index) {
                return SizedBox(
                  width: Utilities.screen(context).w / 1.5,
                  child: CupertinoContextMenuAction(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Future.delayed(const Duration(milliseconds: 250));
                      item[index].onTap();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(item[index].icon != null) Icon(item[index].icon,
                            color: item[index].color, size: 18),
                        if(item[index].icon != null)
                          const SizedBox(width: 6),
                        Text(item[index].name,
                            style: TextStyles.def.colors(item[index]
                                .color ?? MyColor.darkNavy))
                      ]
                    ),
                  ),
                );
              })
            ),
          ),
        );
      }
    );
  }
}

class _CustomRectTween extends RectTween {
  _CustomRectTween({
    required Rect begin,
    required Rect end
  }) : super(begin: begin, end: end);

  Rect custom(double trans) {
    final elasticCurveValue = Curves.linear.transform(trans);
    return Rect.fromLTRB(
      lerpDouble(begin?.left, end?.left, elasticCurveValue)!,
      lerpDouble(begin?.top, end?.top, elasticCurveValue)!,
      lerpDouble(begin?.right, end?.right, elasticCurveValue)!,
      lerpDouble(begin?.bottom, end?.bottom, elasticCurveValue)!,
    );
  }

}

class ToggleBlur extends Cubit<bool> {
  ToggleBlur() : super(false);
  void toggle() => emit(!state);

  void onRefresh() => emit(false);
}

class WidgetMenuButton {
  String name;
  Color? color;
  Function() onTap;
  IconData? icon;

  WidgetMenuButton({
    required this.name,
    this.color = MyColor.darkNavy,
    required this.onTap,
    this.icon
  });
}
