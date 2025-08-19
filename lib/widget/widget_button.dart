import 'package:spa_project/base_project/package.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key,
    this.title = "",
    this.onTap, this.vertical,
    this.horizontal = 0, this.color,
    this.styleTitle, this.borderColor,
    this.textSize, this.radius = 10,
    this.iconLeading, this.leadingColor
  });
  final String title;
  final Color? color, borderColor;
  final Function()? onTap;
  final double? vertical, horizontal, textSize, radius;
  final TextStyle? styleTitle;
  final IconData? iconLeading;
  final Color? leadingColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        return DecoratedBox(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
              border: Border.all(color: borderColor == null ? Colors.transparent : borderColor!, strokeAlign: 1),
          ),
          child: Material(
            color: color ?? MyColor.slateBlue,
            borderRadius: BorderRadius.circular(radius!),
            child: InkWell(
              borderRadius: BorderRadius.circular(radius!),
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: vertical ?? 12, horizontal: horizontal ?? 0),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(iconLeading != null) Padding(
                        padding: EdgeInsets.only(right: title != "" ? 6 : 0),
                        child: Icon(iconLeading, color: leadingColor ?? MyColor.white, size: (textSize ?? 15) * 1.2),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: width - 24 - horizontal!
                        ),
                        child: Text(title, style: styleTitle
                            ?? TextStyles.def.colors(MyColor.white).size(textSize ?? 15).bold)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}