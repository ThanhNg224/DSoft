import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/format_input/auto_money_input.dart';
import 'package:spa_project/view/product/product_partner_add_edit/product_partner_add_edit_controller.dart';
import 'package:spa_project/view/product/product_partner_add_edit/product_partner_add_edit_cubit.dart';

class ProductPartnerAddEditScreen extends BaseView<ProductPartnerAddEditController> {
  static const String router = "/ProductPartnerAddEditScreen";
  const ProductPartnerAddEditScreen({super.key});

  @override
  ProductPartnerAddEditController createController(BuildContext context)
  => ProductPartnerAddEditController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: Utilities.dismissKeyboard,
      child: BlocBuilder<ProductPartnerAddEditCubit, ProductPartnerAddEditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleApp),
            bottomNavigationBar: ColoredBox(
              color: MyColor.white,
              child: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 35),
                  child: Row(
                    children: [
                      Expanded(
                        child: WidgetButton(
                          vertical: 0,
                          title: state.titleApp,
                          onTap: ()=> controller.onAddEditPartner(),
                        ),
                      ),
                      if(controller.args != null) const SizedBox(width: 15),
                      if(controller.args != null) Expanded(
                        child: WidgetButton(
                          vertical: 0,
                          title: "Xóa đối tác",
                          borderColor: MyColor.red,
                          color: MyColor.white,
                          styleTitle: TextStyles.def.bold.colors(MyColor.red),
                          onTap: ()=> controller.onDeletePartner(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: WidgetListView(
              children: [
                WidgetBoxColor(
                  closed: ClosedEnd.start,
                  closedBot: ClosedEnd.end,
                  child: Column(children: [
                    WidgetInput(
                      title: "Tên đối tác",
                      hintText: "Nhập tên đối tác",
                      tick: true,
                      controller: controller.cName,
                      validateValue: state.vaName,
                    ),
                    const SizedBox(height: 10),
                    WidgetInput(
                      title: "Số điện thoại",
                      hintText: "Nhập số điện thoại",
                      tick: true,
                      keyboardType: TextInputType.number,
                      controller: controller.cPhone,
                      validateValue: state.vaPhone,
                      inputFormatters: [AutoFormatInput(type: TypeFormatInput.notCharacters)],
                    ),
                    const SizedBox(height: 10),
                    WidgetInput(
                      title: "Địa chỉ",
                      hintText: "Nhập địa chỉ",
                      controller: controller.cAddress,
                    ),
                    const SizedBox(height: 10),
                    WidgetInput(
                      title: "Email",
                      hintText: "Nhập email",
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.cEmail,
                    ),
                    const SizedBox(height: 10),
                    WidgetInput(
                      title: "Ghi chú",
                      hintText: "Nhập ghi chú",
                      maxLines: 3,
                      controller: controller.cNote,
                    ),
                  ]),
                )
              ]
            ),
          );
        }
      ),
    );
  }
}