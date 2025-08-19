import 'package:spa_project/base_project/package.dart';

class WidgetGridView extends StatelessWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final List<Widget>? children;
  final IndexedWidgetBuilder? itemBuilder;
  final int? itemCount;
  final EdgeInsetsGeometry? padding;
  final Future<void> Function()? onRefresh;
  final Color onRefreshColor;
  final int crossAxisCount;
  final double childAspectRatio;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const WidgetGridView._({
    super.key,
    this.controller,
    this.physics,
    this.children,
    this.itemBuilder,
    this.itemCount,
    this.onRefresh,
    this.padding,
    this.onRefreshColor = MyColor.slateBlue,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 10.0,
    this.mainAxisSpacing = 10.0,
  });

  factory WidgetGridView({
    Key? key,
    ScrollController? controller,
    ScrollPhysics? physics,
    Color onRefreshColor = MyColor.slateBlue,
    required List<Widget> children,
    Future<void> Function()? onRefresh,
    EdgeInsetsGeometry? padding,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 10.0,
    double mainAxisSpacing = 10.0,
  }) => WidgetGridView._(
    key: key,
    controller: controller,
    physics: physics,
    onRefresh: onRefresh,
    onRefreshColor: onRefreshColor,
    padding: padding,
    crossAxisCount: crossAxisCount,
    childAspectRatio: childAspectRatio,
    crossAxisSpacing: crossAxisSpacing,
    mainAxisSpacing: mainAxisSpacing,
    children: children,
  );

  factory WidgetGridView.builder({
    Key? key,
    ScrollController? controller,
    ScrollPhysics? physics,
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    Color onRefreshColor = MyColor.slateBlue,
    EdgeInsetsGeometry? padding,
    Future<void> Function()? onRefresh,
    int crossAxisCount = 2,
    double childAspectRatio = 1.0,
    double crossAxisSpacing = 10.0,
    double mainAxisSpacing = 10.0,
  }) => WidgetGridView._(
    key: key,
    controller: controller,
    physics: physics,
    onRefresh: onRefresh,
    onRefreshColor: onRefreshColor,
    itemBuilder: itemBuilder,
    itemCount: itemCount,
    padding: padding,
    crossAxisCount: crossAxisCount,
    childAspectRatio: childAspectRatio,
    crossAxisSpacing: crossAxisSpacing,
    mainAxisSpacing: mainAxisSpacing,
  );

  @override
  Widget build(BuildContext context) {
    if (onRefresh != null) {
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
                },
              ),
              Positioned(
                top: ((padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)) as EdgeInsets).top,
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
        child: GridView.builder(
          controller: controller,
          physics: effectivePhysics,
          itemCount: itemCount,
          padding: defPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
          ),
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 375),
              columnCount: crossAxisCount,
              child: SlideAnimation(
                verticalOffset: 75,
                child: FadeInAnimation(child: itemBuilder!(context, index)),
              ),
            );
          },
        ),
      );
    } else {
      final List<Widget> safeChildren = children ?? [];
      return AnimationLimiter(
        child: GridView(
          controller: controller,
          physics: effectivePhysics,
          padding: defPadding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
          ),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: 75,
              child: FadeInAnimation(child: widget),
            ),
            children: safeChildren,
          ),
        ),
      );
    }
  }
}
