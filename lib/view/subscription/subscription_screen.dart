import 'dart:io';

import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/subscription/subscription_controller.dart';
import 'package:spa_project/view/subscription/subscription_cubit.dart';

class SubscriptionScreen extends BaseView<SubscriptionController> {
  static const String router = "/SubscriptionScreen";
  const SubscriptionScreen({super.key});

  @override
  SubscriptionController createController(BuildContext context)
  => SubscriptionController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<SubscriptionCubit, SubscriptionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: const WidgetAppBar(title: "Gia hạn tài khoản"),
          body: _body(state)
        );
      }
    );
  }

  Widget _body(SubscriptionState state) {
    if (controller.screenStateIsLoading) {
      return const SizedBox();
    } else if (controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.getPackage()),
              ],
            ),
          ),
        ),
      );
    } else {
      return WidgetListView(
        onRefresh: () async => controller.getPackage(),
        children: [
          if(Platform.isIOS) ..._listPackageIOS(state)
          else ... _listPackageAndroid(state),
          WidgetBoxColor(
            closed: ClosedEnd.start,
            closedBot: ClosedEnd.end,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _itemMonopoly(
                      icon: Icons.account_balance_outlined,
                      title: "Quản lý đại lý",
                      subTitle: "Theo dõi thông tin, doanh số và hiệu xuất của đại lý với báo cáo chi tiết"
                  ),
                  const Divider(indent: 20, endIndent: 20, color: MyColor.sliver),
                  _itemMonopoly(
                      icon: Icons.shopping_basket,
                      title: "Quản lý đơn hàng",
                      subTitle: "Tự động hóa quy trình đặt hàng, theo dõi tình trạng đơn hàng minh bạch"
                  ),
                  const Divider(indent: 20, endIndent: 20, color: MyColor.sliver),
                  _itemMonopoly(
                      icon: Icons.accessibility,
                      title: "Quản lý khách hàng",
                      subTitle: "Xây dựng cơ sở dữ liệu khách hàng, cá nhân hóa tiếp thị và chăm sóc"
                  ),
                  const Divider(indent: 20, endIndent: 20, color: MyColor.sliver),
                  _itemMonopoly(
                      icon: Icons.room_preferences,
                      title: "Quản lý tồn kho",
                      subTitle: "Giám sát hàng hóa, tối ưu xuất nhập kho, giảm thiểu lãng phí"
                  ),
                  const Divider(indent: 20, endIndent: 20, color: MyColor.sliver),
                  _itemMonopoly(
                      icon: Icons.gamepad_rounded,
                      title: "Quản lý cộng tác viên",
                      subTitle: "Theo dõi hoạt động, tăng cường hợp tác và tối ưu hiệu suất"
                  )
                ],
              )
          )
        ]
      );
    }
  }

  List<Widget> _listPackageIOS(SubscriptionState state) {
    return state.packagesIOS.isNotEmpty ? List.generate(state.packagesIOS.length, (index) {
      final pkg = state.packagesIOS[index];
      final product = pkg.storeProduct;

      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: WidgetBoxColor(
          closed: ClosedEnd.start,
          closedBot: ClosedEnd.end,
          child: ListTile(
              title: Text(product.title, style: TextStyles.def.bold),
              subtitle: Text(product.description),
              trailing: Text(product.priceString, style: TextStyles.def.colors(MyColor.green)),
              onTap: () => controller.onPaymentWithIOS(pkg)
          ),
        ),
      );
    }) : [Utilities.listEmpty()];
  }

  List<Widget> _listPackageAndroid(SubscriptionState state) {
    return state.packageAndroid.isNotEmpty ? List.generate(state.packageAndroid.length, (index) {
      final pkg = state.packageAndroid[index];

      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: GestureDetector(
          onTap: ()=> controller.onPaymentWithAndroid(pkg.yer, pkg.price),
          child: WidgetBoxColor(
            closed: ClosedEnd.start,
            closedBot: ClosedEnd.end,
            child: Row(children: [
              const Icon(Icons.credit_card, color: MyColor.slateBlue),
              const SizedBox(width: 10),
              Expanded(child: Text("Gói ${pkg.yer} năm", style: TextStyles.def.bold)),
              Text("đ${pkg.price?.toCurrency()}", style: TextStyles.def)
            ])
          ),
        ),
      );
    }) : [Utilities.listEmpty()];
  }

  Widget _itemMonopoly({
    required IconData icon,
    required String title,
    required String subTitle,
  }) => Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
    DecoratedBox(
      decoration: BoxDecoration(
          color: MyColor.slateBlue,
          borderRadius: BorderRadius.circular(7)
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, color: MyColor.white,),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: TextStyles.def.bold),
        Text(subTitle, style: TextStyles.def.colors(MyColor.hideText).size(12)),
      ]),
    )
  ]);

}