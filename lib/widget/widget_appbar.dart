import 'package:spa_project/base_project/package.dart';

class WidgetAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading, actionIcon;
  final bool? showLeading;
  final double ? leadingWidth;
  final Color? colorTitle, backgroundColor;
  final Gradient? gradient;
  final Function()? actionActive;

  const WidgetAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actionIcon,
    this.actionActive,
    this.leadingWidth,
    this.backgroundColor,
    this.showLeading = true,
    this.gradient, this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? MyColor.white,
      titleTextStyle: const TextStyle(),
      title: Text(title, style: TextStyles.def.bold.size(18).colors(colorTitle?? MyColor.darkNavy)),
      // actions: actions,
      actions: [IconButton(
        onPressed: actionActive,
        icon: actionIcon ?? const SizedBox()
      ), const SizedBox(width: 10)],
      leading: leading ?? _back(context),
      elevation: 0,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: showLeading ?? true,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
    );
  }

  _back(BuildContext context) {
    if(Navigator.canPop(context)) {
      if(showLeading!) {
        return Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: const Center(
              child: Material(
                color: MyColor.nowhere,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.arrow_back_ios_new, size: 20, color: MyColor.darkNavy),
                )
              ),
            ),
          ),
        );
      } else {
        return const SizedBox.shrink();
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}