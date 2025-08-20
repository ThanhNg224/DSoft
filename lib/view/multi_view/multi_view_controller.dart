import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/bed_room/bed_room_screen.dart';
import 'package:spa_project/view/book/book_screen.dart';
import 'package:spa_project/view/combo_treatment/combo_treatment_screen.dart';
import 'package:spa_project/view/multi_view/bloc/multi_view_bloc.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_screen.dart';
import 'package:spa_project/view/product/product_screen.dart';
import 'package:spa_project/view/profile/profile_controller.dart';
import 'package:spa_project/view/service/service_screen.dart';
import 'package:spa_project/view/spa/spa_screen.dart';
import 'package:spa_project/view/staff/staff_screen.dart';
import 'package:spa_project/view/warehouse/warehouse_screen.dart';

import '../custom/custom_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MultiViewController extends BaseController with Repository {
  MultiViewController(super.context);

  late ConfettiController confettiController;
  List<Widget> screen(int index) => [
    AnimatedOpacity(
      opacity: index == 0 ? 1 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: const HomeScreen()
    ),
    AnimatedOpacity(
      opacity: index == 1 ? 1 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: const CustomScreen()
    ),
    AnimatedOpacity(
      opacity: index == 2 ? 1 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: const BookScreen()
    ),
    AnimatedOpacity(
      opacity: index == 3 ? 1 : 0.5,
      duration: const Duration(milliseconds: 300),
      child: ProfileScreen(confettiController: confettiController)
    ),
  ];

  @override
  void onInitState() {
    // final jsonString = Global.getString(Constant.defaultSpa);
    // if (jsonString.isEmpty) WidgetsBinding.instance.addPostFrameCallback((_) => getListSpa());
    // if(jsonString.isNotEmpty) {
    //   final spaMap = jsonDecode(jsonString);
    //   final spaData = Data.fromJson(spaMap);
    //   onTriggerEvent<MultiViewBloc>().add(ChosenSpaMultiViewEvent(spaData));
    // }
    confettiController = ConfettiController(duration: const Duration(seconds: 2));
    super.onInitState();
  }

  void onChangePage(int index) {
    context.read<MultiViewBloc>().add(ChangePageMultiViewEvent(currentIndex: index));
  }

  @override
  void onDispose() {
    confettiController.dispose();
    super.onDispose();
  }

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  static void open() {
    scaffoldKey.currentState?.openDrawer();
  }

  Widget initDrawer(String? avatar) {
    return Drawer(
      backgroundColor: MyColor.nowhere,
      surfaceTintColor: MyColor.nowhere,
      shadowColor: MyColor.nowhere,
      elevation: 0,
      width: Utilities.screen(context).w,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: ()=> Navigator.pop(context),
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Material(color: MyColor.nowhere),
            )
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 80,
              left: 20,
              bottom: 20,
              right: Utilities.screen(context).w * 0.3
            ),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: MyColor.white,
                boxShadow: [BoxShadow(
                  color: MyColor.darkNavy.o3,
                  blurRadius: 50
                )]
              ),
              child: Column(
                children: [
                  ClipRect(child: SizedBox(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: WidgetImage(
                            imageUrl: avatar,
                            width: double.infinity,
                            errorImage: const SizedBox(),
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 20, sigmaX: 20),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [MyColor.white, MyColor.slateBlue.o3],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter
                                )
                              )
                            )
                          ),
                        ),
                        WidgetAvatar(url: avatar, size: 120),
                      ],
                    ),
                  )),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(top: 20, left: 30),
                      children: [
                        _btnDrawer(
                            icon: Icons.shopping_bag_rounded,
                            title: 'Sản phẩm',
                            onTap: ()=> Navigator.pushNamed(context, ProductScreen.router)
                        ),
                        _btnDrawer(
                            icon: Icons.shopping_basket_rounded,
                            title: 'Dịch vụ',
                            onTap: ()=> Navigator.pushNamed(context, ServiceScreen.router)
                        ),
                        _btnDrawer(
                            icon: CupertinoIcons.gift_fill,
                            title: 'Combo liệu trình',
                            onTap: () => Navigator.pushNamed(context, ComboTreatmentScreen.router)
                        ),
                        _btnDrawer(
                            icon: CupertinoIcons.creditcard_fill,
                            title: 'Thẻ trả trước',
                            onTap: () => Navigator.pushNamed(context, PrepaidCardScreen.router)
                        ),
                        _btnDrawer(
                            icon: Icons.warehouse,
                            title: 'Kho hàng',
                            onTap: () => Navigator.pushNamed(context, WarehouseScreen.router)
                        ),
                        _btnDrawer(
                            icon: Icons.king_bed,
                            title: 'Phòng & giường',
                            onTap: ()=> Navigator.pushNamed(context, BedRoomScreen.router)
                        ),
                        _btnDrawer(
                          icon: Icons.group,
                          title: 'Nhân viên',
                          onTap: ()=> Navigator.pushNamed(context, StaffScreen.router)
                        ),
                        _btnDrawer(
                          icon: Icons.spa,
                          title: 'Cơ sở kinh doanh',
                          onTap: ()=> Navigator.pushNamed(context, SpaScreen.router)
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: WidgetButton(
                      color: MyColor.red.o2,
                      title: "Đăng xuất",
                      iconLeading: Icons.power_settings_new_rounded,
                      leadingColor: MyColor.red,
                      styleTitle: TextStyles.def.colors(MyColor.red),
                      onTap: () {
                        Navigator.pop(context);
                        findController<ProfileController>().logOut.perform();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _btnDrawer({IconData? icon, String? title, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        (onTap ?? () {})();
      },
      child: Material(
        color: MyColor.nowhere,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: MyColor.slateBlue.o2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: MyColor.slateBlue),
                )
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(title ?? "", style: TextStyles.def)),
            const Icon(Icons.arrow_forward_ios_rounded, color: MyColor.hideText, size: 17),
            const SizedBox(width: 25)
          ]),
        ),
      ),
    );
  }

}