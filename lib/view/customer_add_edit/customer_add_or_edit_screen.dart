import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/common/model_gender.dart';
import 'package:spa_project/model/response/model_category_customer.dart' as cate;
import 'package:spa_project/model/response/model_list_source_custom.dart' as source;
import 'package:spa_project/view/customer_add_edit/bloc/customer_add_edit_bloc.dart';
import 'package:spa_project/view/customer_add_edit/customer_add_or_edit_controller.dart';

class CustomerAddOrEditScreen extends BaseView<CustomerAddOrEditController> {
  static const String router = "/CustomerAddOrEditScreen";
  const CustomerAddOrEditScreen({super.key});

  @override
  CustomerAddOrEditController createController(BuildContext context) => CustomerAddOrEditController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: BlocBuilder<CustomerAddEditBloc, CustomerAddEditState>(
        builder: (context, state) {
          return Scaffold(
            appBar: WidgetAppBar(title: state.isAddCustomer ? "Thêm khách hàng" : "Sửa thông tin"),
            backgroundColor: MyColor.softWhite,
            body: _body(state),
            bottomNavigationBar: DecoratedBox(
              decoration: BoxDecoration(
                color: MyColor.white,
                boxShadow: [BoxShadow(
                  color: MyColor.darkNavy.o1,
                  blurRadius: 15
                )]
              ),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  child: Row(children: [
                    Expanded(
                      child: WidgetButton(
                        title: controller.args == null ? "Hủy bỏ" : "Xóa thông tin",
                        color: MyColor.white,
                        styleTitle: TextStyles.def.size(15).bold.colors(controller.args == null ? MyColor.darkNavy : MyColor.red),
                        borderColor: controller.args == null ? MyColor.darkNavy : MyColor.red,
                        onTap: ()=> controller.args == null 
                            ? Navigator.pop(context) 
                            : controller.deleteCustomer.perform(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: WidgetButton(
                        title: "Lưu thông tin",
                        onTap: ()=> controller.onSaveInfo(state),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _body(CustomerAddEditState state) {
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
                Utilities.retryButton(controller.onGetMultiple),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else if(controller.screenStateIsLoading) {
      return const SizedBox();
    } else {
      return WidgetListView(
        children: [
          WidgetBoxColor(
              closed: ClosedEnd.start,
              child: GestureDetector(
                onTap: controller.onChoseImage,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    WidgetAvatar(
                        url: state.avatar.isNotEmpty ? state.avatar : "",
                        size: 120
                    ),
                    Utilities.iconCamera()
                  ],
                ),
              )
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Tên khách hàng",
              tick: true,
              hintText: "Nhập tên khách hàng",
              controller: controller.cName,
              validateValue: state.vaName,
            ),
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Số điện thoại",
              tick: true,
              hintText: "Nhập Số điện thoại",
              keyboardType: TextInputType.number,
              controller: controller.cPhone,
              validateValue: state.vaPhone,
            ),
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Email",
              hintText: "Nhập email",
              keyboardType: TextInputType.emailAddress,
              controller: controller.cEmail,
            ),
          ),
          WidgetBoxColor(
            child: WidgetInput(
              title: "Địa chỉ",
              hintText: "Nhập địa chỉ",
              controller: controller.cAddress,
            ),
          ),
          WidgetBoxColor(
            child: WidgetDropDow<ModelGender>(
              title: "Giới tính",
              topTitle: "Giới tính",
              content: [
                WidgetDropSpan(value: ModelGender(name: "Nam", id: 1)),
                WidgetDropSpan(value: ModelGender(name: "Nữ", id: 2)),
              ],
              value: state.currentGender,
              getValue: (item) => item.name ?? "",
              onSelect: (item) {
                controller.idGender = item.id;
                if(state.currentGender?.id == item.id) {
                  context.read<CustomerAddEditBloc>().add(SelectGenderCustomerAddEditEvent(setGenderNull: true));
                } else {
                  context.read<CustomerAddEditBloc>().add(SelectGenderCustomerAddEditEvent(gender: item));
                }
              },
            ),
          ),
          WidgetBoxColor(
            child: WidgetDropDow<cate.Category>(
              title: "Chọn nhóm khách hàng",
              topTitle: "Nhóm khách hàng",
              content: state.listCate
                  .map((item) => WidgetDropSpan(value: item))
                  .toList(),
              value: state.selectCate,
              getValue: (item) => item.name ?? "",
              onSelect: (item) => state.selectCate = item,
              onCreate: ()=> controller.toListCateGory(),
            ),
          ),
          WidgetBoxColor(
            closedBot: ClosedEnd.end,
            child: WidgetDropDow<source.Data>(
              title: "Nguồn",
              topTitle: "Nguồn khách hàng",
              content: state.listSource
                  .map((item) => WidgetDropSpan(value: item))
                  .toList(),
              value: state.selectSource,
              getValue: (item) => item.name ?? "",
              onSelect: (item) => state.selectSource = item,
              onCreate: () => controller.toListSource(),
            ),
          ),
        ]
      );
    }
  }
}