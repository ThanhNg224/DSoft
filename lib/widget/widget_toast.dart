import 'package:spa_project/base_project/package.dart';

class WidgetToast extends StatefulWidget {
  final VoidCallback onClose;
  final String message;
  const WidgetToast({super.key, required this.onClose, required this.message});

  @override
  State<WidgetToast> createState() => _WidgetToastState();
}

class _WidgetToastState extends State<WidgetToast>
    with SingleTickerProviderStateMixin {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => opacity = 0.0);

      Future.delayed(const Duration(milliseconds: 500), () {
        widget.onClose();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10.0),
        constraints: const BoxConstraints(
          maxWidth: 200,
        ),
        child: Text(
          widget.message,
          style: TextStyles.def.colors(MyColor.white).size(13).light,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}