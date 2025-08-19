import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';

class WidgetToolSearch extends StatelessWidget {
  final bool isLoading;
  final String titleSearch;
  final TextEditingController? controller;
  final Function(String)? onChangeSearch;
  final Widget? filter;
  final Function()? onFilter;
  final EdgeInsetsGeometry? padding;
  const WidgetToolSearch({super.key,
    this.isLoading = false,
    this.onFilter, this.controller,
    this.onChangeSearch,
    this.titleSearch = "Tìm kiếm",
    this.filter, this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.nowhere,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(child: WidgetInput(
              hintText: titleSearch,
              controller: controller,
              prefixIcon: const Icon(CupertinoIcons.search),
              onChange: onChangeSearch,
              suffixIcon: AnimatedScale(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastEaseInToSlowEaseOut,
                scale: isLoading ? 0.3 : 0,
                child: const WidgetCircularWait(strokeWidth: 6)
              ),
            )),
            if(filter != null) IconButton(
              onPressed: () => _open(context),
              icon: SvgPicture.asset(MyImage.iconFilter)
            )
          ],
        ),
      ),
    );
  }

  void _open(BuildContext context) {
    Utilities.dismissKeyboard();
    PopupOverlay.$Popup(context,
      title: "Tìm kiếm",
      content: filter!,
      bottom: Row(children: [
        Expanded(child: WidgetButton(
          title: "Hủy",
          onTap: () => Navigator.pop(context),
          color: MyColor.sliver,
          vertical: 7,
          styleTitle: TextStyles.def.colors(MyColor.darkNavy).size(15).bold,
        )),
        const SizedBox(width: 10),
        Expanded(child: WidgetButton(
          title: "Tìm kiếm",
          vertical: 7,
          onTap: () {
            Navigator.pop(context);
            (onFilter ?? () {})();
          },
        ))
      ])
    );
  }
}
