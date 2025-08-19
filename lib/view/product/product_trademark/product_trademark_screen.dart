import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_trademark.dart';
import 'package:spa_project/view/product/product_trademark/product_trademark_controller.dart';
import 'package:spa_project/view/product/product_trademark/product_trademark_cubit.dart';

class ProductTrademarkScreen extends BaseView<ProductTrademarkController> {
  const ProductTrademarkScreen({super.key});

  @override
  ProductTrademarkController createController(BuildContext context)
  => ProductTrademarkController(context);

  @override
  Widget zBuild() {
    return ColoredBox(
      color: MyColor.softWhite,
      child: BlocBuilder<ProductTrademarkCubit, List<Data>>(
        builder: (context, data) {
          return _body(data);
        }
      )
    );
  }

  Widget _body(List<Data> data) {
    if(controller.screenStateIsLoading) {
      return const SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
          child: WidgetShimmer(radius: 20),
        )
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              const SizedBox(height: 10),
              Utilities.retryButton(()=> controller.onGetListTrademark(true)),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      if(data.isEmpty) {
        return WidgetListView(
            onRefresh: () async => controller.onGetListTrademark(true),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView(
          onRefresh: () async => controller.onGetListTrademark(false),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            WidgetBoxColor(
                closed: ClosedEnd.start,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: MyColor.borderInput,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Row(children: [
                        Text("ID", style: TextStyles.def.colors(MyColor.slateGray).bold.size(12)),
                        const SizedBox(width: 30),
                        Expanded(child: Text("Tên nhãn hiệu", style: TextStyles.def.colors(MyColor.slateGray).bold.size(12))),
                      ]),
                    ),
                  ),
                )
            ),
            ...List.generate(data.length, (index) {
              return WidgetBoxColor(
                closedBot: index == data.length - 1 ? ClosedEnd.end : null,
                child: WidgetPopupMenu(
                  name: "category_product_$index",
                  menu: [
                    WidgetMenuButton(
                        name: "Sửa danh mục",
                        icon: Icons.edit_rounded,
                        color: MyColor.slateBlue,
                        onTap: () => controller.onChangeTrademark(data[index].id, data[index].name, data[index].description)
                    ),
                    WidgetMenuButton(
                        name: "Xóa",
                        color: MyColor.red,
                        icon: CupertinoIcons.delete,
                        onTap: () => controller.onDeleteTradeProduct(data[index].id, name: data[index].name)
                    ),
                  ],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ColoredBox(
                      color: MyColor.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Row(children: [
                          Text(data[index].id.toString(), style: TextStyles.def.colors(MyColor.slateGray).bold),
                          const SizedBox(width: 30),
                          Expanded(child: Text(data[index].name ?? "", style: TextStyles.def.colors(MyColor.slateGray).bold)),
                        ]),
                      ),
                    ),
                  ),
                ),
              );
            })
          ]
      );
    }
  }
}