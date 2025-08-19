import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_cart.dart';
import 'package:spa_project/view/combo_treatment/combo_treatment_screen.dart';
import 'package:spa_project/view/order/order_add_cart/order_add_cart_controller.dart';
import 'package:spa_project/view/product/product_screen.dart';
import 'package:badges/badges.dart' as badges;
import 'package:spa_project/view/service/service_screen.dart';
import '../../../widget/widget_add_to_cart.dart';
import 'bloc/order_add_cart_bloc.dart';

class OrderAddCartScreen extends BaseView<OrderAddCartController> {
  static const String router = "/OrderProductCreatedScreen";
  const OrderAddCartScreen({super.key});

  @override
  OrderAddCartController createController(BuildContext context)
  => OrderAddCartController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<OrderAddCartBloc, OrderAddCartState>(
        builder: (context, state) {
          return WidgetAddToCart(
            builder: (animation) {
              return Scaffold(
                backgroundColor: MyColor.softWhite,
                appBar: WidgetAppBar(
                  title: "Tạo đơn ${controller.handleTitleAppBar()}",
                  actionIcon: animation.end(badges.Badge(
                      badgeContent: Text(state.listCart.length > 9 ? "9+" : "${state.listCart.length}",
                          style: TextStyles.def.bold.colors(MyColor.white).size(9)),
                      showBadge: state.listCart.isNotEmpty,
                      position: badges.BadgePosition.topEnd(top: -10, end: -13),
                      child: const Icon(CupertinoIcons.cart_fill, color: MyColor.slateGray)
                  )),
                ),
                body: _$handleForObject(animation, state),
                bottomNavigationBar: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 35),
                    child: WidgetButton(
                      title: "Thông tin đơn hàng",
                      vertical: 0,
                      onTap: ()  => Navigator.pop(context),
                    ),
                  ),
                ),
              );
            }
          );
        }
    );
  }

  Widget _$handleForObject(AnimationWrapper animation, OrderAddCartState state) {
    if(controller.isProductOrder) {
      return _bodyWithProduct(animation, state);
    } else if(controller.isServiceOrder) {
      return _bodyWithService(animation, state);
    } else if(controller.isComboOrder) {
      return _bodyWithCombo(animation, state);
    } else if(controller.isPrepaidCard) {
      return _bodyWithPrepaidCard(animation, state);
    } else {
      return const SizedBox();
    }
  }

  Widget _bodyWithProduct(AnimationWrapper animation, OrderAddCartState state) {
    if(controller.screenStateIsLoading) {
      return Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Chọn sản phẩm để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
          ),
        ),
        Expanded(
          child: WidgetGridView.builder(
            itemCount: 6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const WidgetShimmer(radius: 20);
            },
          ),
        )
      ]);
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
              Utilities.retryButton(()=> controller.getListProduct.onGetListProduct()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Chọn sản phẩm để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
        ),
        if(state.listProduct.isEmpty) Expanded(
          child: WidgetListView(
              onRefresh: () async => controller.getListProduct.onGetListProduct(),
              children: [
                Utilities.listEmpty(),
                const Icon(Icons.add, color: MyColor.slateBlue),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ProductScreen.router).whenComplete(() {
                      controller.getListProduct.onGetListProduct();
                    });
                  },
                  child: Text("Thêm sản phẩm", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
                )
              ]
          ),
        ) else Expanded(
            child: WidgetGridView.builder(
              itemCount: state.listProduct.length,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              onRefresh: () async => controller.getListProduct.onGetListProduct(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemBuilder: (context, index) {
                return animation.start(
                    item: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                        color: MyColor.white,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned.fill(child: Image.network(
                                  state.listProduct[index].image ?? "",
                                  headers: const {'Cache-Control': 'no-cache'},
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    debugPrint('⚠️ Image load failed: ');
                                    return Image.asset(MyImage.noImage);
                                  }
                              )),
                              IntrinsicHeight(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        gradient: LinearGradient(
                                            colors: [MyColor.black.o0, MyColor.black.o7],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: const [0.0, 0.8]
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(state.listProduct[index].name ?? "Đang cập nhật",
                                                  style: TextStyles.def.bold.colors(MyColor.white).size(14),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text("đ${(state.listProduct[index].price ?? 0).toCurrency()}",
                                                  style: TextStyles.def.bold.colors(MyColor.white).size(12),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: ColoredBox(
                                                  color: MyColor.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Center(child: Text("×${state.listProduct[index].quantity ?? 0}", style: TextStyles.def.bold.size(12))),
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                    call: () => controller.onAddToCart(ModelAddCart(
                      id: state.listProduct[index].id,
                      name: state.listProduct[index].name,
                      price: state.listProduct[index].price ?? 0,
                      image: state.listProduct[index].image,
                    ), index)
                );
              },
            )
        ),
      ]);
    }
  }

  Widget _bodyWithService(AnimationWrapper animation, OrderAddCartState state) {
    if(controller.screenStateIsLoading) {
      return Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Chọn sản phẩm để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
          ),
        ),
        Expanded(
          child: WidgetGridView.builder(
            itemCount: 6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const WidgetShimmer(radius: 20);
            },
          ),
        )
      ]);
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
              Utilities.retryButton(()=> controller.getListProduct.onGetListProduct()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Chọn dịch vụ để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
        ),
        if(state.listService.isEmpty) Expanded(
          child: WidgetListView(
              onRefresh: () async => controller.getServiceList.getList(),
              children: [
                Utilities.listEmpty(),
                const Icon(Icons.add, color: MyColor.slateBlue),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ServiceScreen.router).whenComplete(() {
                      controller.getServiceList.getList();
                    });
                  },
                  child: Text("Thêm dịch vụ", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
                )
              ]
          ),
        ) else Expanded(
            child: WidgetGridView.builder(
              itemCount: state.listService.length,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              onRefresh: () async => controller.getServiceList.getList(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemBuilder: (context, index) {
                return animation.start(
                    item: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                        color: MyColor.white,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned.fill(child: Image.network(
                                  state.listService[index].image ?? "",
                                  headers: const {'Cache-Control': 'no-cache'},
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    debugPrint('⚠️ Image load failed: ');
                                    return Image.asset(MyImage.noImage);
                                  }
                              )),
                              IntrinsicHeight(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        gradient: LinearGradient(
                                            colors: [MyColor.black.o0, MyColor.black.o7],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: const [0.0, 0.8]
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(state.listService[index].name ?? "Đang cập nhật",
                                            style: TextStyles.def.bold.colors(MyColor.white).size(14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text("đ${(state.listService[index].price ?? 0).toCurrency()}",
                                            style: TextStyles.def.bold.colors(MyColor.white).size(12),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                    call: () => controller.onAddToCart(ModelAddCart(
                      id: state.listService[index].id,
                      name: state.listService[index].name,
                      price: state.listService[index].price ?? 0,
                      image: state.listService[index].image,
                    ), index)
                );
              },
            )
        ),
      ]);
    }
  }

  Widget _bodyWithCombo(AnimationWrapper animation, OrderAddCartState state) {
    if(controller.screenStateIsLoading) {
      return Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Chọn sản phẩm để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
          ),
        ),
        Expanded(
          child: WidgetGridView.builder(
            itemCount: 6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const WidgetShimmer(radius: 20);
            },
          ),
        )
      ]);
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
              Utilities.retryButton(()=> controller.getListCombo.onGetListCombo()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Chọn dịch vụ để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
        ),
        if(state.listCombo.isEmpty) Expanded(
          child: WidgetListView(
              onRefresh: () async => controller.getListCombo.onGetListCombo(),
              children: [
                Utilities.listEmpty(),
                const Icon(Icons.add, color: MyColor.slateBlue),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ComboTreatmentScreen.router).whenComplete(() {
                      controller.getListCombo.onGetListCombo();
                    });
                  },
                  child: Text("Thêm combo liệu trình", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
                )
              ]
          ),
        ) else Expanded(
            child: WidgetGridView.builder(
              itemCount: state.listCombo.length,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              onRefresh: () async => controller.getListCombo.onGetListCombo(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemBuilder: (context, index) {
                return animation.start(
                    item: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: ColoredBox(
                        color: MyColor.white,
                        child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Positioned.fill(child: Image.network(
                                  "${state.listCombo[index].image}",
                                  headers: const {'Cache-Control': 'no-cache'},
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, _, __) {
                                    debugPrint('⚠️ Image load failed: ');
                                    return Image.asset(MyImage.noImage);
                                  }
                              )),
                              IntrinsicHeight(
                                child: SizedBox(
                                  width: double.infinity,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        gradient: LinearGradient(
                                            colors: [MyColor.black.o0, MyColor.black.o7],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            stops: const [0.0, 0.8]
                                        )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(state.listCombo[index].name ?? "Đang cập nhật",
                                                  style: TextStyles.def.bold.colors(MyColor.white).size(14),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text("đ${(state.listCombo[index].price ?? 0).toCurrency()}",
                                                  style: TextStyles.def.bold.colors(MyColor.white).size(12),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: ColoredBox(
                                                  color: MyColor.white,
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 5),
                                                    child: Center(child: Text("×${state.listCombo[index].quantity ?? 0}", style: TextStyles.def.bold.size(12))),
                                                  )
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    ),
                    call: () => controller.onAddToCart(ModelAddCart(
                      id: state.listCombo[index].id,
                      name: state.listCombo[index].name,
                      price: state.listCombo[index].price ?? 0,
                      image: state.listCombo[index].image,
                    ), index)
                );
              },
            )
        ),
      ]);
    }
  }

  Widget _bodyWithPrepaidCard(AnimationWrapper animation, OrderAddCartState state) {
    if(controller.screenStateIsLoading) {
      return Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text("Chọn sản phẩm để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
          ),
        ),
        Expanded(
          child: WidgetGridView.builder(
            itemCount: 6,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const WidgetShimmer(radius: 20);
            },
          ),
        )
      ]);
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
              Utilities.retryButton(()=> controller.getListPrepaidCard.onGetListPrepaid()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text("Chọn để thêm vào thông tin đơn hàng", style: TextStyles.def.colors(MyColor.hideText).italic.size(12).bold),
        ),
        if(state.listPrepaid.isEmpty) Expanded(
          child: WidgetListView(
              onRefresh: () async => controller.getListPrepaidCard.onGetListPrepaid(),
              children: [
                Utilities.listEmpty(),
                const Icon(Icons.add, color: MyColor.slateBlue),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ComboTreatmentScreen.router).whenComplete(() {
                      controller.getListPrepaidCard.onGetListPrepaid();
                    });
                  },
                  child: Text("Thêm combo liệu trình", style: TextStyles.def.bold.colors(MyColor.slateBlue)),
                )
              ]
          ),
        ) else Expanded(
            child: WidgetListView.builder(
              itemCount: state.listPrepaid.length,
              onRefresh: () async => controller.getListPrepaidCard.onGetListPrepaid(),
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
              itemBuilder: (context, index) {
                return animation.start(
                    item: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: WidgetBoxColor(
                          closed: ClosedEnd.start,
                          closedBot: ClosedEnd.end,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.listPrepaid[index].name ?? "Đang cập nhật",
                                style: TextStyles.def.bold.size(17),
                              ),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                      child: ColoredBox(color: MyColor.slateBlue),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _infoCount(title: "Giá bán:", data: "${state.listPrepaid[index].price?.toCurrency(suffix: "đ")}"),
                                          _infoCount(title: "Mệnh giá sử dụng:", data: "${state.listPrepaid[index].priceSell?.toCurrency(suffix: "đ")}"),
                                          _infoCount(title: "Thời hạn:", data: "${state.listPrepaid[index].useTime} ngày"),
                                          _infoCount(title: "Trạng thái:", data: state.listPrepaid[index].status == "active" ? "Hoạt động" : "Không hoạt động"),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      ),
                    ),
                    call: () => controller.onAddToCart(ModelAddCart(
                      id: state.listPrepaid[index].id,
                      name: state.listPrepaid[index].name,
                      price: state.listPrepaid[index].price ?? 0,
                      priceSell: state.listPrepaid[index].priceSell ?? 0,
                    ), index)
                );
              },
            )
        ),
      ]);
    }
  }

  Widget _infoCount({required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(title, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
        Expanded(child: Divider(height: 10, indent: 5, endIndent: 5, color: MyColor.sliver.o3)),
        Text(data, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
      ]),
    );
  }
}