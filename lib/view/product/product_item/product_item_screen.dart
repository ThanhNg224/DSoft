import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_product.dart';
import 'package:spa_project/view/product/product_item/product_item_controller.dart';
import 'package:spa_project/view/product/product_item/product_item_cubit.dart';

class ProductItemScreen extends BaseView<ProductItemController> {
  const ProductItemScreen({super.key});

  @override
  ProductItemController createController(BuildContext context)
  => ProductItemController(context);

  @override
  Widget zBuild() {
    return ColoredBox(
      color: MyColor.softWhite,
      child: BlocBuilder<ProductItemCubit, List<Data>>(
        builder: (context, data) {
          return _body(data);
        }
      ),
    );
  }

  Widget _body(List<Data> data) {
    if(controller.screenStateIsLoading) {
      return ListView.separated(
        itemCount: 6,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          return const WidgetShimmer(
            width: double.infinity,
            radius: 20,
            height: 120,
          );
        },
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
              Utilities.retryButton(()=> controller.onGetListProduct(true)),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      if(data.isEmpty) {
        return WidgetListView(
          onRefresh: () async => controller.onGetListProduct(true),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView.builder(
        itemCount: data.length,
        onRefresh: () async => controller.onGetListProduct(false),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: GestureDetector(
              onTap: () => controller.onToChangeProduct(data[index]),
              child: WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Row(children: [
                  WidgetImage(
                    imageUrl: data[index].image,
                    width: 80,
                    height: 50,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data[index].name ?? "", style: TextStyles.def.bold),
                        Text("${(data[index].price ?? 0 ).toCurrency()}vnd",
                            style: TextStyles.def.bold.colors(MyColor.hideText)),
                      ]
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(data[index].status == "active" ? "Hiển thị" : "Khóa",
                        style: TextStyles.def.colors(data[index].status == "active"
                            ? MyColor.green
                            : MyColor.red
                        ).size(11).bold
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: ColoredBox(
                          color: MyColor.borderInput,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                            child: Text("×${data[index].quantity ?? 0}", style: TextStyles.def),
                          ),
                        ),
                      )
                    ],
                  )
                ])
              ),
            ),
          );
        },
      );
    }
  }
}