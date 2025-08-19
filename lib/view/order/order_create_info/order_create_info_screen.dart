import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/common/model_payment_method.dart';
import 'package:spa_project/model/response/model_list_repo.dart' as repo;
import 'package:spa_project/model/response/model_list_staff.dart' as staff;
import 'package:spa_project/view/order/order_create_info/order_create_info_controller.dart';
import 'package:spa_project/view/order/order_create_info/order_create_info_cubit.dart';
import 'package:spa_project/view/order/order_add_cart/order_add_cart_screen.dart';
import 'package:spa_project/view/staff_add_edit/staff_add_edit_screen.dart';
import 'package:spa_project/view/warehouse/warehouse_screen.dart';

class OrderCreateInfoScreen extends BaseView<OrderCreateInfoController> {
  static const String router = "/OrderCreateInfoScreen";
  const OrderCreateInfoScreen({super.key});

  @override
  OrderCreateInfoController createController(BuildContext context)
  => OrderCreateInfoController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<OrderCreateInfoCubit, OrderCreateInfoState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: "Thông tin đơn ${controller.nameOrder()}"),
            bottomNavigationBar: ColoredBox(
              color: MyColor.white,
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
                  child: WidgetButton(
                    title: state.btnTitle,
                    vertical: 0,
                    onTap: ()=> controller.handlePayment(state),
                  ),
                ),
              ),
            ),
            body: _body(state),
          ),
        );
      }
    );
  }

  Widget _body(OrderCreateInfoState state) {
    if(controller.screenStateIsLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: WidgetShimmer(
          radius: 20,
          height: 400,
          width: double.infinity,
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
              Utilities.retryButton(()=> controller.onGetMultiple()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return WidgetListView(children: [
        WidgetBoxColor(
          closed: ClosedEnd.start,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tên khách hàng", style: TextStyles.def),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: controller.onOpenViewSearch,
                child: SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: state.vaName.isEmpty ? MyColor.borderInput : MyColor.red)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                      child: state.vaName.isEmpty ? Text(controller.nameCustomer.name ?? "Nhập tên khách hàng",
                          style: TextStyles.def.colors(controller.nameCustomer.name == null
                              ? MyColor.hideText
                              : MyColor.darkNavy
                          )
                      ) : Text(state.vaName, style: TextStyles.def.colors(MyColor.red)),
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
        WidgetBoxColor(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thời gian", style: TextStyles.def),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: controller.onOpenSelectDateTime,
              child: SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyColor.borderInput)
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                      child: Text(controller.dateTimeValue.formatDateTime(), style: TextStyles.def)
                  ),
                ),
              ),
            ),
          ],
        )),
        if(controller.isReceptionService) WidgetBoxColor(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Giường & phòng", style: TextStyles.def),
            const SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyColor.borderInput)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  child: Text(controller.args?.bedData?.name ?? "Không có thông tin", style: TextStyles.def)
                ),
              ),
            ),
          ],
        )),
        if(controller.isProductOrder || controller.isComboOrder) WidgetBoxColor(child: WidgetDropDow<repo.Data>(
          title: "chọn kho hàng",
          topTitle: "Kho hàng",
          content: state.listRepo.map((item) => WidgetDropSpan(value: item)).toList(),
          getValue: (item) => item.name ?? "",
          value: state.choseRepo,
          tick: true,
          validate: state.vaRepo,
          onCreate: () => Navigator.pushNamed(context, WarehouseScreen.router).whenComplete(() {
            GetListRepo().perform();
          }),
          onSelect: (value) => state.choseRepo = value
        )),
        WidgetBoxColor(child: Utilities.viewSpaDefault),
        WidgetBoxColor(closedBot: ClosedEnd.end, child: WidgetDropDow<staff.Data>(
          title: "chọn nhân viên",
          topTitle: "Nhân viên",
          content: state.listStaff.map((item) => WidgetDropSpan(value: item)).toList(),
          getValue: (item) => item.name ?? "",
          value: state.choseStaff,
          validate: state.vaStaff,
          tick: true,
          onSelect: (value) => state.choseStaff = value,
          onCreate: () => Navigator.pushNamed(context, StaffAddEditScreen.router).whenComplete(() {
            GetListStaff().perform();
          }),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Expanded(child: Text("${controller.nameOrder(capitalize: true)} hiện có", style: TextStyles.def.bold.size(18))),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, OrderAddCartScreen.router, arguments: controller.args?.type),
              child: Text("Thêm", style: TextStyles.def.colors(MyColor.slateBlue).bold)
            )
          ]),
        ),
        if(state.listCart.isEmpty)
          // Utilities.listEmpty(content: "Vui lòng chọn ${controller.nameOrder()}")
          Center(
            child: SizedBox(
              width: 200,
              child: WidgetButton(
                title: "Vui lòng chọn ${controller.nameOrder()}",
                vertical: 8,
                color: MyColor.red,
                onTap: () => Navigator.pushNamed(context, OrderAddCartScreen.router, arguments: controller.args?.type),
              ),
            ),
          )
        else DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: MyColor.sliver
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedList(
              key: controller.listKey,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              initialItemCount: state.listCart.length,
              itemBuilder: (context, index, animation) {
                return _buildAnimatedItem(index, state, animation);
              },
            ),
          ),
        ),
        if(!controller.isReceptionService) Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text("Thông tin thanhh toán", style: TextStyles.def.bold.size(18)),
        ),
        if(!controller.isReceptionService) Column(children: [
          WidgetBoxColor(
              closed: ClosedEnd.start,
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Text("Thành tiền", style: TextStyles.def.bold)),
                Text(controller.makeMoney(state.listCart).toCurrency(suffix: "đ"))
              ])
          ),
          WidgetBoxColor(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetInput(
                title: "Giảm giá",
                hintText: "Nhập giảm giá",
                controller: controller.cDeCreasePrice,
                keyboardType: TextInputType.number,
                inputFormatters: [AutoFormatInput()],
                onChange: (value) {
                  if(value.removeCommaMoney > 100) {
                    context.read<OrderCreateInfoCubit>()
                        .setTypeDeCreaseIsPercent(false);
                  } else {
                    context.read<OrderCreateInfoCubit>()
                        .setTypeDeCreaseIsPercent(true);
                  }
                },
                suffixIcon: !state.isPercent ? Transform.translate(
                    offset: const Offset(0, 12),
                    child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText))
                ) : const Icon(Icons.percent, color: MyColor.hideText),
              ),
              Text("Có thể giảm theo phần trăm, hoặc giá trực tiếp", style:
              TextStyles.def.colors(MyColor.hideText).italic.bold.size(12))
            ],
          )),
          WidgetBoxColor(
              child: WidgetDropDow<ModelPaymentMethod>(
                  title: "Hình thức",
                  topTitle: "Hình thức thanh toán",
                  content: ModelPaymentMethod.listPaymentMethod
                      .map((item) => WidgetDropSpan(value: item))
                      .toList(),
                  validate: state.vaPaymentMethod,
                  getValue: (item) => item.name,
                  value: state.chosePaymentMethod,
                  onSelect: (item) => state.chosePaymentMethod = item
              )
          ),
          WidgetBoxColor(
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Text("Tổng thanh toán", style: TextStyles.def.bold)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if(controller.cDeCreasePrice.text.isNotEmpty) Text(controller.makeMoney(state.listCart)
                        .toCurrency(suffix: "đ"), style:
                    TextStyles.def.lineThrough(thickness: 2).colors(MyColor.slateGray).size(12)),
                    Text(controller.finalMoney(state.listCart).toCurrency(suffix: "đ"), style:
                    TextStyles.def.bold),
                  ],
                )
              ])
          ),
          WidgetBoxColor(
              closedBot: ClosedEnd.end,
              child: WidgetInput(
                title: "Ghi chú",
                controller: controller.cNote,
                maxLines: 3,
                hintText: "Nhập nội dung",
              )
          ),
        ])
      ]);
    }
  }

  Widget _buildAnimatedItem(int index, OrderCreateInfoState state, Animation<double> animation) {
    return Padding(
      padding: EdgeInsets.only(bottom: index == (state.listCart.length - 1) ? 0 : 15),
      child: SizeTransition(
        sizeFactor: animation,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    WidgetImage(imageUrl: state.listCart[index].image, width: 70, height: 70),
                    const SizedBox(width: 15),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.listCart[index].name ?? "", style: TextStyles.def.bold),
                        Text("đ${(state.listCart[index].price).toCurrency()}", style: TextStyles.def.colors(MyColor.hideText)),
                      ],
                    )),
                    IconButton(
                      onPressed: ()=> controller.onRemoteItemInCart(index, state, _buildAnimatedItem),
                      icon: const Icon(CupertinoIcons.delete, color: MyColor.red)
                    )
                  ],
                ),
                Row(children: [
                  Expanded(child: Text("Số lượng", style: TextStyles.def.bold)),
                  IconButton(
                    onPressed: () => controller.onDecrease(index, state),
                    icon: const Icon(Icons.indeterminate_check_box, color: MyColor.slateGray)
                  ),
                  Text(state.listCart[index].quantity.toString(), style: TextStyles.def.bold),
                  IconButton(
                    onPressed: () => controller.onIncrease(index, state),
                    icon: const Icon(Icons.add_box_rounded, color: MyColor.slateGray)
                  ),
                ]),
                Row(children: [
                  Expanded(child: Text("Tổng", style: TextStyles.def.bold)),
                  Text("đ${(state.listCart[index].price * state.listCart[index].quantity).toCurrency()}",
                  style: TextStyles.def.bold.colors(MyColor.green))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }


}