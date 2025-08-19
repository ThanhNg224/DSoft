import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_book_calendar.dart';
import 'package:spa_project/widget/widget_toast.dart';
import 'package:spa_project/model/response/model_list_spa.dart' as spa;

class Utilities {
  static void initSplash() {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  }

  static void removeSplash() async {
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  static Screen screen(BuildContext context) => Screen(context);

  static ScrollPhysics defaultScroll = const BouncingScrollPhysics().applyTo(const AlwaysScrollableScrollPhysics());

  static void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static Widget errorCodeWidget(int? errorCode, {Function()? onTap}) {
    switch(errorCode) {
      case Result.isHttp: return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ErrorExceptionWidget.isHttp,
          if(onTap != null) _ErrorExceptionWidget.reTryAction(onTap)
        ],
      );
      case Result.isTimeOut: return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ErrorExceptionWidget.isTimeOut,
          if(onTap != null) _ErrorExceptionWidget.reTryAction(onTap)
        ],
      );
      case Result.isNotConnect: return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ErrorExceptionWidget.isNotConnect,
          if(onTap != null) _ErrorExceptionWidget.reTryAction(onTap)
        ],
      );
      case Result.isDueServer: return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ErrorExceptionWidget.isDueServer,
          if(onTap != null) _ErrorExceptionWidget.reTryAction(onTap)
        ],
      );
      case Result.isOk: return const SizedBox();
      case Result.isError: default: return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ErrorExceptionWidget.isError,
          if(onTap != null) _ErrorExceptionWidget.reTryAction(onTap)
        ],
      );
    }
  }

  static Widget errorMesWidget(String message)
  => _ErrorExceptionWidget.setMessage(message);

  static void openOtpView({
    required BuildContext context,
    required void Function() action,
    TextEditingController? controller,
    String? title, required String info
  }) {
    controller?.clear();
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return _OtpScreen(
        action: action,
        controller: controller,
        title: title,
        info: info,
      );
    }));
  }

  static void openSuccessView({
    required BuildContext context,
    required String textButton,
    required Function() action,
    String? title,
    String? subTitle
  }) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) {
      return _SuccessView(
        action: action,
        text: textButton,
        title: title,
        subTitle: subTitle,
      );
    }));
  }
  
  static Widget listEmpty({String? content}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(
          MyAnimation.listEmpty,
          height: 250,
          repeat: false
        ),
        Transform.translate(
          offset: const Offset(0, -30),
          child: Text(content ?? "Danh sách trống", style: TextStyles.def.colors(MyColor.hideText))
        )
      ]
    );
  }

  static Widget iconCamera({double size = 20}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MyColor.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(
          color: MyColor.darkNavy.o3,
          blurRadius: 10
        )]
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Icon(Icons.camera_alt_outlined, size: size),
      ),
    );
  }

  static String statusCodeSpaToMes(int? status) {
    switch (status) {
      case 0: return "Chưa xác nhận";
      case 1: return "Xác nhận";
      case 2: return "Không đến";
      case 3: return "Đã đến";
      default: return "Hủy lịch";
    }
  }

  static Color statusCodeSpaToColor(int? status) {
    switch (status) {
      case 0: return MyColor.yellow;
      case 1: return MyColor.slateBlue;
      case 2: return MyColor.slateGray;
      case 3: return MyColor.green;
      default: return MyColor.red;
    }
  }

  static String? getSelectedTypes(Data? data) {
    List<String> selectedTitles = [];

    if (data?.type1 == 1) selectedTitles.add("Lịch tư vấn");
    if (data?.type2 == 1) selectedTitles.add("Lịch chăm sóc");
    if (data?.type3 == 1) selectedTitles.add("Lịch liệu trình");
    if (data?.type4 == 1) selectedTitles.add("Lịch điều trị");

    return selectedTitles.isNotEmpty ? selectedTitles.join(', ') : "";
  }

  static Widget retryButton(Function() onTap) => _ErrorExceptionWidget.reTryAction(onTap);

  static void openToast(BuildContext context, String message) {
    OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: WidgetToast(
            onClose: () => overlayEntry?.remove(),
            message: message,
          ),
        ),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry?.remove();
    });
  }

  static Widget get viewSpaDefault {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text("Cơ sở kinh doanh", style: TextStyles.def),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColor.borderInput
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
              child: Text(spa.Data.fromJson(jsonDecode(Global.getString(Constant.defaultSpa))).name ?? "Chưa cập nhật")
            ),
          ),
        ),
      ],
    );
  }

  static int? get getIdSpaDefault {
    final spaString = Global.getString(Constant.defaultSpa);
    if(spaString.isEmpty) return null;
    final spaMap = jsonDecode(spaString);
    final spaData = spa.Data.fromJson(spaMap);
    return spaData.id;
  }

  static spa.Data? get chosenSpa {
    final spaString = Global.getString(Constant.defaultSpa);
    if(spaString.isEmpty) return null;
    final spaMap = jsonDecode(spaString);
    final spaData = spa.Data.fromJson(spaMap);
    return spaData;
  }

}

final class Screen {
  BuildContext context;
  Screen(this.context);

  double get h => MediaQuery.of(context).size.height;

  double get w => MediaQuery.of(context).size.width;
}

final class _OtpScreen extends StatelessWidget {
  final void Function() action;
  final TextEditingController? controller;
  final String? title;
  final String info;
  const _OtpScreen({
    required this.action,
    this.controller,
    this.title,
    required this.info
  });

  @override
  Widget build(BuildContext context) {
    double widthPinPut = (Utilities.screen(context).w - 100)/4;
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: Scaffold(
        backgroundColor: MyColor.white,
        appBar: WidgetAppBar(title: title ?? ""),
        body: ListView(
          physics: Utilities.defaultScroll,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: MySize.bothSides),
          children: [
            Text("Nhập mã xác nhận", style: TextStyles.def.size(24).bold),
            const SizedBox(height: 10),
            RichText(text: TextSpan(children: [
              TextSpan(
                  text: "Chúng tôi đã gửi một mã xác nhận tới số ",
                  style: TextStyles.def.size(18).colors(MyColor.slateGray)
              ),
              TextSpan(
                  text: info,
                  style: TextStyles.def.size(18).colors(MyColor.green)
              ),
            ])),
            const SizedBox(height: 30),
            Center(
              child: Pinput(
                controller: controller,
                defaultPinTheme: PinTheme(
                  width: widthPinPut,
                  height: widthPinPut - 10,
                  textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyColor.sliver, width: 1.2),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: widthPinPut,
                  height: widthPinPut - 10,
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MyColor.green, width: 1.5),
                  ),
                ),
                separatorBuilder: (index) => const SizedBox(width: 20),
              ),
            ),
            const SizedBox(height: 30),
            Center(child: Text("Không nhận được mã?",
                style: TextStyles.def.colors(MyColor.slateBlue).semiBold
            ))
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(MySize.bothSides, 10, MySize.bothSides, 40),
            child: WidgetButton(
              title: "Tiếp theo",
              onTap: ()=> action(),
            ),
          ),
        ),
      ),
    );
  }
}

final class _SuccessView extends StatelessWidget {
  final String text;
  final Function() action;
  final String? title, subTitle;
  const _SuccessView({
    required this.text,
    required this.action,
    this.title, this.subTitle
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MyColor.white,
      child: ListView(
        padding: EdgeInsets.only(
          right: MySize.bothSides,
          left: MySize.bothSides,
          bottom: 30,
          top: Utilities.screen(context).h / 10
        ),
        physics: Utilities.defaultScroll,
        children: [
          Lottie.asset(
              MyAnimation.success, repeat: false,
              height: 280,
              fit: BoxFit.contain
          ),
          Text(title ?? "",
            style: TextStyles.def.size(24).bold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(subTitle ?? "",
            style: TextStyles.def,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          WidgetButton(
            title: text,
            onTap: action,
          )
        ],
      ),
    );
  }
}

final class _ErrorExceptionWidget {

  static Widget get isHttp => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset(MyAnimation.connectSever, width: 200),
      Text("Lỗi kết nối, vui lòng thử lại sau.",
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      )
    ],
  );

  static Widget get isTimeOut => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset(MyAnimation.connectSever, width: 200),
      Text("Máy chủ không phản hồi, vui lòng thử lại.",
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      )
    ],
  );

  static Widget get isDueServer => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Opacity(
        opacity: 0.5,
        child: ClipOval(child: Lottie.asset(MyAnimation.dueSever, width: 240))
      ),
      const SizedBox(height: 8),
      Text("Máy chủ không phản hồi, vui lòng thử lại.",
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      )
    ],
  );

  static Widget get isNotConnect => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Image.asset(MyImage.noInternet, height: 130, width: 130),
      Text("Không có kết nối mạng, hãy kiểm tra Internet và thử lại.",
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      )
    ],
  );

  static Widget get isError => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Transform.scale(
        scale: 1.3,
        child: Lottie.asset(MyAnimation.error, repeat: false, height: 120, width: 120)
      ),
      Text("Đã xảy ra lỗi, vui lòng thử lại.",
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      )
    ],
  );

  static Widget setMessage(String message, {Function()? onTap}) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Transform.scale(
        scale: 1.3,
        child: Lottie.asset(MyAnimation.error, repeat: false, height: 120, width: 120)
      ),
      Text(message,
        style: TextStyles.def.colors(MyColor.slateGray),
        textAlign: TextAlign.center,
      ),
      if(onTap != null) reTryAction(onTap)
    ],
  );

  static Widget reTryAction(Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        width: 120,
        child: WidgetButton(
          vertical: 7,
          title: "Thử lại",
          onTap: onTap,
        ),
      ),
    );
  }
}

class StatusBook {
  static int pending = 0;
  static int confirmed = 1;
  static int noShow = 2;
  static int arrived = 3;
  static int cancelled = 4;
}
