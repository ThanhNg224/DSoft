import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_category_customer.dart';
import 'package:spa_project/view/custom_category/custom_cate_controller.dart';
import 'package:spa_project/view/custom_category/custom_cate_cubit.dart';

class CustomCateScreen extends BaseView<CustomCateController> {
  static const String router = "/CustomCateScreen";
  const CustomCateScreen({super.key});

  @override
  CustomCateController createController(BuildContext context)
  => CustomCateController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: BlocBuilder<CustomCateCubit, List<Category>>(
        builder: (context, data) {
          return _body(data);
        }
      ),
    );
  }

  Widget _body(List<Category> data) {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 6,
        itemBuilder: (_, __) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              width: double.infinity,
              height: 100,
              radius: 20,
            ),
          );
        },
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                Utilities.retryButton(() => controller.getListCateGory(true)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      if(data.isEmpty) {
        return WidgetListView(
          onRefresh: () async => controller.getListCateGory(false),
          children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView.builder(
        onRefresh: () async => controller.getListCateGory(false),
        itemCount: data.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: WidgetBoxColor(
              closed: ClosedEnd.start,
              closedBot: ClosedEnd.end,
              child: Row(children: [
                Expanded(child: Text(data[index].name ?? 'Đang cập nhật', style: TextStyles.def.bold.colors(MyColor.slateGray))),
                GestureDetector(
                  onTap: () => controller.onOpenAddEditCate(id: data[index].id, name: data[index].name),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: MyColor.softWhite,
                      shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.edit_note_outlined, color: MyColor.slateBlue),
                    )
                  ),
                ),
                const SizedBox(width: 7),
                GestureDetector(
                  onTap: ()=> controller.onDeleteCate(data[index].id, name: data[index].name),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(
                      color: MyColor.softWhite,
                      shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_outline, color: MyColor.red),
                    )
                  ),
                ),
              ])
            ),
          );
        }, 
      );
    }
  }
}