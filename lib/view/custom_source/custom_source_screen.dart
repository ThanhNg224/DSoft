import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_source_custom.dart';
import 'package:spa_project/view/custom_source/custom_source_controller.dart';
import 'package:spa_project/view/custom_source/custom_source_cubit.dart';

class CustomSourceScreen extends BaseView<CustomSourceController> {
  static const String router = "/CustomSourceScreen";
  const CustomSourceScreen({super.key});

  @override
  CustomSourceController createController(BuildContext context)
  => CustomSourceController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      body: BlocBuilder<CustomSourceCubit, List<Data>>(
        builder: (context, data) {
          return _body(data);
        }
      ),
    );
  }

  Widget _body(List<Data> data) {
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
                Utilities.retryButton(() => controller.getListSource(true)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      if(data.isEmpty) {
        return WidgetListView(
          onRefresh: () async => controller.getListSource(false),
          children: [Utilities.listEmpty()]
        );
      }
      return WidgetListView.builder(
        onRefresh: () async => controller.getListSource(false),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: WidgetBoxColor(
                closed: ClosedEnd.start,
                closedBot: ClosedEnd.end,
                child: Row(children: [
                  Expanded(child: Text(data[index].name ?? 'Đang cập nhật', style: TextStyles.def.bold.colors(MyColor.slateGray))),
                  GestureDetector(
                    onTap: () => controller.onOpenAddEditSource(id: data[index].id, name: data[index].name),
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
                    onTap: ()=> controller.onDeleteSource(data[index].id, name: data[index].name),
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