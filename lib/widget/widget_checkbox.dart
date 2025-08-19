import 'package:spa_project/base_project/package.dart';

class WidgetCheckbox extends StatelessWidget {
  const WidgetCheckbox({super.key, required this.onChanged, required this.value, this.title, this.style});

  final Function(bool?) onChanged;
  final bool value;
  final String? title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
      child: GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) => onChanged(value),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              activeColor: MyColor.green,
            ),
            const SizedBox(width: 5),
            if(title != null) Expanded(child: Text(title!, style: style ?? TextStyles.def))
          ],
        ),
      ),
    );
  }
}
