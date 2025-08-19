import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';

enum StatusSnackBar {
  SUCCESS,
  FAILURE,
  WARNING
}

mixin PopupOverlay {
  BuildContext get context;

  Future<void> popupBottom({required Widget child}) {
    return _PopupOverlay._showBottom(context, child);
  }

  static void $PopupBottom(BuildContext context, {required Widget child}) {
    _PopupOverlay._showBottom(context, child);
  }

  void loadingFullScreen() {
    _PopupOverlay._showLoadingDialog(context);
  }

  static void $LoadingFullScreen(BuildContext context) {
    _PopupOverlay._showLoadingDialog(context);
  }

  void hideLoading() => Navigator.pop(context);

  static void $HideLoading(BuildContext context) => Navigator.pop(context);

  void successSnackBar({String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.SUCCESS,
      message: message ?? ""
  );

  static void $SuccessSnackBar(BuildContext context, {String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.SUCCESS,
      message: message ?? ""
  );

  void errorSnackBar({String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.FAILURE,
      message: message ?? ""
  );

  static void $ErrorSnackBar(BuildContext context, {String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.FAILURE,
      message: message ?? ""
  );

  void warningSnackBar({String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.WARNING,
      message: message ?? ""
  );

  static void $WarningSnackBar(BuildContext context, {String? message}) => _PopupOverlay._snackBar(
      context: context,
      status: StatusSnackBar.WARNING,
      message: message ?? ""
  );

  void popup({
    String title = "Thông báo",
    bool showBottom = true,
    bool barrierDismissible = true,
    TextStyle? styleTitle,
    Widget? bottom,
    Widget? content}) {
    _PopupOverlay._showDialog(
        context,
        barrierDismissible,
        showBottom,
        title,
        styleTitle,
        content,
        bottom
    );
  }

  static void $Popup(BuildContext context, {
    String title = "Thông báo",
    bool? showBottom = true,
    bool barrierDismissible = true,
    TextStyle? styleTitle,
    Widget? bottom,
    Widget? content}) {
    _PopupOverlay._showDialog(
        context,
        barrierDismissible,
        showBottom!,
        title,
        styleTitle,
        content,
        bottom
    );
  }

  PopupConfirm popupConfirm({
    String title = "Thông báo",
    required Widget content,
    bool barrierDismissible = true,
  }) => PopupConfirm(
    title: title,
    content: content,
    context: context,
    barrierDismissible: barrierDismissible
  );
}

class _PopupOverlay {
  static void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            color: MyColor.white,
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }

  static Future<void> _showBottom(BuildContext context, Widget child) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: MyColor.darkNavy.o1,
      builder: (context) {
        return ColoredBox(
          color: MyColor.white,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9, // Cho phép mở rộng đến 90% nếu nội dung lớn
            ),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MySize.bothSides, vertical: 20),
                  child: child,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void _showDialog(
    BuildContext context,
    bool barrierDismissible,
    bool showBottom,
    String title,
    TextStyle? styleTitle,
    Widget? content,
    Widget? bottom,
  ) => showCupertinoDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return PopScope(
            canPop: barrierDismissible,
            child: Dialog(
              backgroundColor: MyColor.white,
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15))
              ),
              clipBehavior: Clip.antiAlias,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: Utilities.screen(context).h / 1.8,
                  maxWidth: 380
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColoredBox(
                      color: MyColor.borderInput,
                      child: Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              child: Text(title, style: styleTitle ?? TextStyles.def.bold.size(17), textAlign: TextAlign.center),
                            ),
                          ),
                          if(barrierDismissible) Positioned(
                            right: 10,
                            child: Material(
                              color: MyColor.sliver,
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(100),
                              child: InkWell(
                                onTap: ()=> Navigator.pop(context),
                                child: const Padding(
                                  padding: EdgeInsets.all(6.0),
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      child: content ?? const SizedBox(),
                    )),
                    if(showBottom) Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      child: bottom ?? SizedBox(
                        width: 100,
                        child: WidgetButton(
                          title: "Đóng",
                          vertical: 5,
                          onTap: ()=> Navigator.pop(context),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );

  static void _snackBar({
    required BuildContext context,
    required StatusSnackBar status,
    required String message}) {
    Color color = MyColor.green;
    String title = "Thành công";
    IconData icon = Icons.check_circle;

    switch(status) {
      case StatusSnackBar.FAILURE:
        color = MyColor.red;
        title = "Thất bại";
        icon = Icons.error;
        break;
      case StatusSnackBar.WARNING:
        color = const Color(0xFFFAA134);
        title = "";
        icon = Icons.warning_rounded;
        break;
      case StatusSnackBar.SUCCESS:
        color = MyColor.green;
        title = "Thành công";
        icon = Icons.check_circle;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: GestureDetector(
          onTap: ()=> ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  Icon(icon, color: MyColor.white),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      if(title.isNotEmpty) Text(title, style: TextStyles.def.bold.colors(MyColor.white)),
                      Text(message),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PopupConfirm {
  final Widget content;
  final String title;
  final BuildContext context;
  final bool barrierDismissible;

  PopupConfirm({
    required this.content,
    this.title = "Thông báo",
    required this.context,
    this.barrierDismissible = true,
  });

  /// Normal popup - nền xanh, 1 nút OK
  void normal() {
    PopupOverlay.$Popup(
      context,
      title: title,
      barrierDismissible: barrierDismissible,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: content
      ),
    );
  }

  /// Serious popup - nền đỏ, 2 nút Không/Đồng ý
  void serious({required VoidCallback onTap, bool disableDefaultBack = false}) {
    PopupOverlay.$Popup(
      context,
      title: title,
      barrierDismissible: barrierDismissible,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: content
      ),
      bottom: _bottom(onTap, MyColor.red, disableDefaultBack: disableDefaultBack),
    );
  }

  /// Confirm popup - nền xanh, 2 nút Huỷ/Xác nhận
  void confirm({required VoidCallback onConfirm, bool disableDefaultBack = false}) {
    PopupOverlay.$Popup(
      context,
      title: title,
      barrierDismissible: barrierDismissible,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: content
      ),
      bottom: _bottom(onConfirm, MyColor.slateBlue, disableDefaultBack: disableDefaultBack),
    );
  }

  Widget _bottom(VoidCallback onTap, Color color, {bool disableDefaultBack = false}) {
    return SizedBox(
      width: 100,
      child: WidgetButton(
        title: "Đồng ý",
        vertical: 5,
        color: color,
        styleTitle: TextStyles.def.colors(MyColor.white).size(15).bold,
        onTap: () {
          if(!disableDefaultBack) Navigator.pop(context);
          onTap();
        },
      ),
    );
  }
}

