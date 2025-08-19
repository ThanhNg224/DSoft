import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/model/response/model_list_cate_product.dart';
import 'package:spa_project/model/response/model_list_trademark.dart';
import 'package:spa_project/view/product/product_item_add_edit/bloc/product_item_add_edit_bloc.dart';
import 'package:spa_project/view/product/product_item_add_edit/product_item_add_edit_controller.dart';

class ProductItemAddEditScreen extends BaseView<ProductItemAddEditController> {
  static const String router = "/ProductItemAddEditScreen";
  const ProductItemAddEditScreen({super.key});

  @override
  ProductItemAddEditController createController(BuildContext context)
  => ProductItemAddEditController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ProductItemAddEditBloc, ProductItemAddEditState>(
      builder: (context, state) {
        if(controller.screenStateIsError) {
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
                    Utilities.retryButton(() => controller.onGetMultiple()),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        }
        return GestureDetector(
          onTap: Utilities.dismissKeyboard,
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleView),
            bottomNavigationBar: ColoredBox(
              color: MyColor.white,
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Row(children: [
                    if(controller.args != null) Expanded(
                      child: WidgetButton(
                        title: "Xóa sản phẩm",
                        vertical: 0,
                        borderColor: MyColor.red,
                        color: MyColor.white,
                        styleTitle: TextStyles.def.colors(MyColor.red).bold,
                        onTap: controller.onDeleteProduct,
                      ),
                    ),
                    if(controller.args != null) const SizedBox(width: 15),
                    Expanded(
                      child: WidgetButton(
                        title: state.titleView,
                        vertical: 0,
                        onTap: controller.onAddEditProduct,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            body: WidgetListView(
              children: [
                WidgetBoxColor(
                  closed: ClosedEnd.start,
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: _boxImage(state)
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Tên sản phẩm",
                    validateValue: state.vaName,
                    tick: true,
                    hintText: "Nhập tên sản phẩm",
                    controller: controller.cName,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Giá sản phẩm",
                    tick: true,
                    validateValue: state.vaPrice,
                    hintText: "Nhập giá sản phẩm",
                    keyboardType: TextInputType.number,
                    controller: controller.cPrice,
                    inputFormatters: [AutoFormatInput()],
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                    ),
                  )
                ),
                WidgetBoxColor(
                  child: WidgetDropDow<ModelDetailCateProduct>(
                    title: "Chọn danh mục",
                    topTitle: "Danh mục sản phẩm",
                    tick: true,
                    content: List.generate(state.listCate.length, (index) {
                      return WidgetDropSpan(value: state.listCate[index]);
                    }),
                    validate: state.vaCate,
                    value: state.choseCate,
                    getValue: (item) => item.name ?? "",
                    onSelect: (item) => context.read<ProductItemAddEditBloc>().add(ChoseDropDowProductItemAddEditEvent(
                      choseCate: item
                    )),
                  )
                ),
                WidgetBoxColor(
                  child: WidgetDropDow<Data>(
                    title: "Chọn nhãn hiệu",
                    topTitle: "Nhãn hiệu",
                    tick: true,
                    validate: state.vaTrademark,
                    value: state.choseTrademark,
                    content: List.generate(state.listTrademark.length, (index) {
                      return WidgetDropSpan(value: state.listTrademark[index]);
                    }),
                    getValue: (item) => item.name ?? "",
                    onSelect: (item) => context.read<ProductItemAddEditBloc>().add(ChoseDropDowProductItemAddEditEvent(
                      choseTrademark: item
                    )),
                  )
                ),
                WidgetBoxColor(
                    child: WidgetInput(
                      title: "Mã sản phẩm",
                      hintText: "Nhập mã sản phẩm",
                      controller: controller.cCodeProduct,
                    )
                ),
                WidgetBoxColor(
                  child: Row(children: [
                    Text("Trạng thái: ", style: TextStyles.def.size(18).bold),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 1000),
                        transitionBuilder: (child, animation) {
                          final curved = CurvedAnimation(
                            parent: animation,
                            curve: Curves.elasticInOut,
                          );
                          return ScaleTransition(
                            scale: curved,
                            alignment: Alignment.centerLeft,
                            child: child
                          );
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          key: ValueKey(state.statusProduct),
                          child: Text(
                            state.statusProduct == StatusAccountStaff.isLock ? "Khóa" : "Hiển thị",
                            textAlign: TextAlign.left,
                            style: TextStyles.def.size(18).bold.colors(StatusAccountStaff.color(state.statusProduct)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.change_circle_sharp),
                      onPressed: ()=> context.read<ProductItemAddEditBloc>().add(ChangeStatusProductItemAddEditEvent()),
                    )
                  ])
                ),
                WidgetBoxColor(
                    child: WidgetInput(
                      title: "Mô tả ngắn sản phẩm",
                      hintText: "Nhập mô tả ngắn sản phẩm",
                      controller: controller.cDescription,
                    )
                ),
                WidgetBoxColor(
                  closedBot: ClosedEnd.end,
                  child: WidgetInput(
                    maxLines: 3,
                    title: "Mô tả sản phẩm",
                    hintText: "Nhập mô tả sản phẩm",
                    controller: controller.cInfo,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text("Cài đặt hoa hồng sản phẩm", style: TextStyles.def.bold.size(18)),
                ),
                WidgetBoxColor(
                  closed: ClosedEnd.start,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Hệ thống sẽ ưu tiên tính tiền cố định trước rồi mới đến tính theo hoa hồng",
                            style: TextStyles.def.colors(MyColor.red)),
                        const SizedBox(height: 10),
                        WidgetInput(
                          title: "Nhân viên",
                          hintText: "Trả số tiền cố định",
                          controller: controller.cPriceForStaff,
                          inputFormatters: [AutoFormatInput()],
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(child: Text("Trả theo", style: TextStyles.def)),
                          Text("${state.commissionStaffPercent}%", style: TextStyles.def)
                        ]),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackShape: const RectangularSliderTrackShape(),
                            trackHeight: 3.0,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                          ),
                          child: Slider(
                            value: state.commissionStaffPercent.toDouble(),
                            min: 0,
                            max: 100,
                            activeColor: MyColor.slateBlue,
                            label: 50.round().toString(),
                            onChanged: (double value) {
                              context.read<ProductItemAddEditBloc>().add(ChangeSlideProductItemAddEditEvent(
                                commissionStaffPercent: value.round()
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                ),
                WidgetBoxColor(
                  closedBot: ClosedEnd.end,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        WidgetInput(
                          title: "Người giới thiệu",
                          hintText: "Trả số tiền cố định",
                          controller: controller.cPriceForAffiliate,
                          inputFormatters: [AutoFormatInput()],
                          keyboardType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text("VND", style: TextStyles.def.bold.colors(MyColor.hideText)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(children: [
                          Expanded(child: Text("Trả theo", style: TextStyles.def)),
                          Text("${state.commissionAffiliatePercent}%", style: TextStyles.def)
                        ]),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackShape: const RectangularSliderTrackShape(),
                            trackHeight: 3.0,
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
                          ),
                          child: Slider(
                            value: state.commissionAffiliatePercent.toDouble(),
                            min: 0,
                            max: 100,
                            activeColor: MyColor.slateBlue,
                            label: 50.round().toString(),
                            onChanged: (double value) {
                              context.read<ProductItemAddEditBloc>().add(ChangeSlideProductItemAddEditEvent(
                                commissionAffiliatePercent: value.round()
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget _boxImage(ProductItemAddEditState state) {
    return GestureDetector(
      onTap: controller.onChoseImage,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColor.borderInput
        ),
        child: Center(
          child: WidgetImage(
            imageUrl: state.fileImage,
            width: double.infinity,
            errorImage: state.fileImage.isEmpty ? const Icon(
              Icons.add,
              color: MyColor.sliver,
              size: 80,
            ) : null
          ),
        ),
      ),
    );
  }
}