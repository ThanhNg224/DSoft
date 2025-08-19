import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_partner.dart';
import 'package:spa_project/view/product/product_controller.dart';
import 'package:spa_project/view/product/product_partner/product_partner_controller.dart';
import 'package:spa_project/view/product/product_partner/product_partner_cubit.dart';

class ProductPartnerScreen extends BaseView<ProductPartnerController> {
  static const String router = "/ProductPartnerScreen";
  const ProductPartnerScreen({super.key});

  @override
  ProductPartnerController createController(BuildContext context)
  => ProductPartnerController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ProductPartnerCubit, List<Data>>(
      builder: (context, data) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          body: _body(data)
        );
      }
    );
  }

  Widget _body(List<Data> data) {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: WidgetShimmer(
            width: double.infinity,
            height: 130,
          ),
        ),
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
              Utilities.retryButton(()=> controller.onGetListPartner()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return data.isNotEmpty ? WidgetListView.builder(
        onRefresh: () async => controller.onGetListPartner(isLoad: false),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => findController<ProductController>().onToAddEditProductPartner(index: index),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: MyColor.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(children: [
                        Expanded(child: Text(data[index].name ?? "", style: TextStyles.def.bold.size(18))),
                        Text("ID: ${data[index].id}", style: TextStyles.def.colors(MyColor.hideText).size(12))
                      ]),
                      Container(
                        decoration: BoxDecoration(
                          color: MyColor.borderInput,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(children: [
                            const Icon(CupertinoIcons.phone_circle, color: MyColor.slateGray),
                            const SizedBox(width: 10),
                            Text(data[index].phone ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.slateGray))
                          ]),
                          const SizedBox(height: 5),
                          Row(children: [
                            const Icon(Icons.attach_email_outlined, color: MyColor.slateGray),
                            const SizedBox(width: 10),
                            Expanded(child: Text(data[index].email == "" || (data[index].email ?? "").isEmpty ? "Đang cập nhật" : data[index].email!,
                                style: TextStyles.def.colors(MyColor.slateGray))
                            )
                          ]),
                          const SizedBox(height: 5),
                          Row(crossAxisAlignment: CrossAxisAlignment.start,children: [
                            const Icon(Icons.home_work_outlined, color: MyColor.slateGray),
                            const SizedBox(width: 10),
                            Expanded(child: Text(data[index].address ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.slateGray)))
                          ])
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ) : WidgetListView(
        onRefresh: () async => controller.onGetListPartner(isLoad: false),
        children: [Utilities.listEmpty()]
      );
    }
  }
}