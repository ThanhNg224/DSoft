import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_controller.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_screen.dart';
import 'package:spa_project/view/order/order_cubit.dart';
import 'package:spa_project/view/order/order_prepaid_card/order_prepaid_card_screen.dart';
import 'package:spa_project/view/order/order_product/order_product_screen.dart';
import 'package:spa_project/view/order/order_service/order_service_screen.dart';
import 'package:spa_project/view/order/order_treatment/order_treatment_screen.dart';

class OrderScreen extends StatelessWidget {
  static const String router = "/OrderScreen";

  const OrderScreen({super.key});

  void handleAction(BuildContext context, int index) {
    switch (index) {
      case 1 :
        Navigator.pushNamed(context,
            OrderCreateInfoScreen.router,
            arguments: ToOrderCreateInfo(type: OrderCreateInfoType.comboTreatment)
        );
        break;
      case 2 :
        Navigator.pushNamed(context,
            OrderCreateInfoScreen.router,
            arguments: ToOrderCreateInfo(type: OrderCreateInfoType.product)
        );
        break;
      case 3 :
        Navigator.pushNamed(context,
            OrderCreateInfoScreen.router,
            arguments: ToOrderCreateInfo(type: OrderCreateInfoType.prepaidCard)
        );
        break;
      case 0 : default :
        Navigator.pushNamed(context,
            OrderCreateInfoScreen.router,
            arguments: ToOrderCreateInfo(type: OrderCreateInfoType.service)
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as int?;
    if(args != null && args == 1) context.read<OrderCubit>().onChangePageIndex(args);

    return BlocBuilder<OrderCubit, int>(
      builder: (context, indexPage) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Đơn hàng",
            actionIcon: WidgetButton(
              iconLeading: Icons.add,
              onTap: () => handleAction(context, indexPage),
              vertical: 0,
              horizontal: 10,
            ),
          ),
          body: Column(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
                physics: Utilities.defaultScroll,
                scrollDirection: Axis.horizontal,
                child: Row(children: [
                  WidgetButton(
                    title: "Đơn dịch vụ",
                    horizontal: 20,
                    color: indexPage == 0 ? MyColor.green : MyColor.sliver,
                    vertical: 7,
                    onTap: ()=> context.read<OrderCubit>().onChangePageIndex(0),
                  ),
                  const SizedBox(width: 20),
                  WidgetButton(
                    title: "Đơn combo",
                    color: indexPage == 1 ? MyColor.green : MyColor.sliver,
                    horizontal: 20,
                    vertical: 7,
                    onTap: ()=> context.read<OrderCubit>().onChangePageIndex(1),
                  ),
                  const SizedBox(width: 20),
                  WidgetButton(
                    title: "Đơn sản phẩm",
                    color: indexPage == 2 ? MyColor.green : MyColor.sliver,
                    horizontal: 20,
                    vertical: 7,
                    onTap: ()=> context.read<OrderCubit>().onChangePageIndex(2),
                  ),
                  const SizedBox(width: 20),
                  WidgetButton(
                    title: "Đơn thẻ trả trước",
                    color: indexPage == 3 ? MyColor.green : MyColor.sliver,
                    horizontal: 20,
                    vertical: 7,
                    onTap: ()=> context.read<OrderCubit>().onChangePageIndex(3),
                  ),
                ]),
              ),
              Expanded(child: _viewComponent[indexPage]
              )
            ]
          ),
        );
      }
    );
  }

  List<Widget> get _viewComponent => [
    const OrderServiceScreen(),
    const OrderTreatmentScreen(),
    const OrderProductScreen(),
    const OrderPrepaidCardScreen()
  ];
}