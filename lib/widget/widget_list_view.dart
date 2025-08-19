import 'package:spa_project/base_project/package.dart';

class WidgetListView extends StatelessWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final List<Widget>? children;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final EdgeInsetsGeometry? padding;
  final Future<void> Function()? onRefresh;
  final Color onRefreshColor;

  const WidgetListView._({
    super.key,
    this.controller,
    this.physics,
    this.children,
    this.itemBuilder,
    this.itemCount,
    this.onRefresh,
    this.padding,
    this.onRefreshColor = MyColor.slateBlue
  });

  factory WidgetListView({
    Key? key,
    ScrollController? controller,
    ScrollPhysics? physics,
    Color onRefreshColor = MyColor.slateBlue,
    required List<Widget> children,
    Future<void> Function()? onRefresh,
    EdgeInsetsGeometry? padding
  }) {
    return WidgetListView._(
      key: key,
      controller: controller,
      physics: physics,
      onRefresh: onRefresh,
      onRefreshColor: onRefreshColor,
      padding: padding,
      children: children,
    );
  }

  factory WidgetListView.builder({
    Key? key,
    ScrollController? controller,
    ScrollPhysics? physics,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    Color onRefreshColor = MyColor.slateBlue,
    EdgeInsetsGeometry? padding,
    Future<void> Function()? onRefresh
  }) {
    return WidgetListView._(
      key: key,
      controller: controller,
      physics: physics,
      onRefresh: onRefresh,
      onRefreshColor: onRefreshColor,
      itemBuilder: itemBuilder,
      itemCount: itemCount,
      padding: padding,
    );
  }

  @override
  Widget build(BuildContext context) {
    if(onRefresh != null) {
      return CustomRefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        builder: (context, child, controller) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 300),
                tween: Tween<double>(begin: 0, end: controller.isLoading ? 30 : 0),
                curve: Curves.ease,
                builder: (context, value, _) {
                  return Padding(
                    padding: EdgeInsets.only(top: value),
                    child: child,
                  );
                }
              ),
              Positioned(
                top: 16.0,
                child: Opacity(
                  opacity: controller.value.clamp(0.0, 1.0),
                  child: WidgetLoading(color: onRefreshColor),
                ),
              ),
            ],
          );
        },
        child: _body(),
      );
    } else {
      return _body();
    }
  }

  Widget _body() {
    final ScrollPhysics effectivePhysics = physics ?? Utilities.defaultScroll;
    final EdgeInsetsGeometry defPadding = padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 20);

    if (itemBuilder != null && itemCount != null) {
      return AnimationLimiter(
        child: ListView.builder(
          controller: controller,
          physics: effectivePhysics,
          itemCount: itemCount,
          padding: defPadding,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 20.0,
                child: FadeInAnimation(
                  child: itemBuilder!(context, index),
                ),
              ),
            );
          },
        ),
      );
    } else {
      final List<Widget> safeChildren = children ?? [];
      return AnimationLimiter(
        child: ListView(
          controller: controller,
          physics: effectivePhysics,
          padding: defPadding,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 20,
              child: FadeInAnimation(child: widget),
            ),
            children: safeChildren,
          ),
        ),
      );
    }
  }
}

