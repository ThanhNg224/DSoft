import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/product/product_category/product_category_screen.dart';
import 'package:spa_project/view/product/product_controller.dart';
import 'package:spa_project/view/product/product_cubit.dart';
import 'package:spa_project/view/product/product_partner/product_partner_screen.dart';

import 'product_item/product_item_screen.dart';
import 'product_trademark/product_trademark_screen.dart';

class ProductScreen extends BaseView<ProductController> {
  static const String router = "/ProductScreen";
  const ProductScreen({super.key});

  @override
  ProductController createController(BuildContext context)
  => ProductController(context);

  List<Widget> _body() => [
    const ProductItemScreen(),
    const ProductCategoryScreen(),
    const ProductTrademarkScreen(),
    const ProductPartnerScreen(),
  ];

  @override
  Widget zBuild() {
    return BlocBuilder<ProductCubit, int>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Sản phẩm",
            actionIcon: WidgetButton(
              title: "",
              iconLeading: Icons.add,
              onTap: ()=> controller.handleRouter(state),
              vertical: 0,
              horizontal: 10,
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: Utilities.defaultScroll,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(children: [
                    WidgetButton(
                      title: "Sản phẩm",
                      color: state == 0 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () => context.read<ProductCubit>().onChangePage(0),
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Danh mục",
                      horizontal: 20,
                      vertical: 7,
                      color: state == 1 ? MyColor.green : MyColor.sliver,
                      onTap: () => context.read<ProductCubit>().onChangePage(1),
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Nhãn hiệu",
                      horizontal: 20,
                      vertical: 7,
                      color: state == 2 ? MyColor.green : MyColor.sliver,
                      onTap: () => context.read<ProductCubit>().onChangePage(2),
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Đối tác",
                      horizontal: 20,
                      vertical: 7,
                      color: state == 3 ? MyColor.green : MyColor.sliver,
                      onTap: () => context.read<ProductCubit>().onChangePage(3),
                    ),
                  ]),
                ),
              ),
              Expanded(child: _body()[state])
            ],
          ),
        );
      }
    );
  }


}
