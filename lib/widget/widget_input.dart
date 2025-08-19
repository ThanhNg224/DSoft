import 'package:flutter/services.dart';
import 'package:spa_project/base_project/package.dart';

class WidgetInput extends StatelessWidget {
  const WidgetInput({super.key,
    this.enabled, this.keyboardType,
    this.maxLines, this.controller,
    this.hintText, this.hintStyle,
    this.suffixIcon, this.obscureText, this.prefixIcon,
    this.validateValue, this.title, this.maxLength,
    this.onChange, this.tick = false,
    this.focusNode, this.inputFormatters,
    this.textAlign = TextAlign.start
  });

  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled, obscureText, tick;
  final TextInputType? keyboardType;
  final int? maxLines, maxLength;
  final TextEditingController? controller;
  final String? hintText, validateValue, title;
  final TextStyle? hintStyle;
  final Widget? suffixIcon, prefixIcon;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          if(title != null && (title??'').isNotEmpty) Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(title??'', style: TextStyles.def),
          ),
          const SizedBox(width: 5),
          if(tick!) Text("*", style: TextStyles.def.colors(MyColor.red).size(18))
        ]),
        DecoratedBox(
          decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: (validateValue != null && (validateValue??'').isNotEmpty)
                  ? MyColor.red : MyColor.borderInput,
              width: 1.0
            )
          ),
          child: TextField(
            textAlign: textAlign,
            cursorColor: MyColor.slateBlue,
            enabled: enabled,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            keyboardType: keyboardType ?? TextInputType.text,
            obscureText: obscureText ?? false,
            controller: controller,
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
            onChanged: (value) {
              if (onChange != null) onChange!(value);
            },
            decoration: InputDecoration(
              counterText: '',
              contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
              suffixIcon: suffixIcon,
              hintStyle: hintStyle ?? TextStyles.def.colors(MyColor.hideText).regular,
              hintText: hintText ?? '',
              border: InputBorder.none,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
        if (validateValue != null && (validateValue??'').isNotEmpty)
          Text(validateValue ?? '', style: TextStyles.def.colors(MyColor.red).medium.size(12)),
      ],
    );
  }
}
