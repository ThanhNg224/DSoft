import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_spa.dart';
import 'package:spa_project/view/chose_spa/chose_spa_controller.dart';

class ChoseSpaScreen extends BaseView<ChoseSpaController> {
  static const String router = "/ChoseSpaScreen";
  const ChoseSpaScreen({super.key});

  @override
  ChoseSpaController createController(BuildContext context)
  => ChoseSpaController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: controller.args == ChoseSpaController.fromProfile ? const WidgetAppBar(
        title: "Cơ sở kinh doanh"
      ) : null,
      body: WidgetListView(
        padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(top: 200)),
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColor.white,
                boxShadow: [BoxShadow(
                    blurRadius: 10,
                    color: MyColor.hideText.o5
                )]
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0).add(const EdgeInsets.only(bottom: 20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phần mềm quản lý dịch vụ! 👋", style: TextStyles.def.bold.size(18).colors(MyColor.hideText)),
                  Text("Mời bạn chọn cơ sở kinh doanh", style: TextStyles.def.bold.colors(MyColor.hideText)),
                  WidgetDropDow<Data>(
                    title: "Chọn cơ sở kinh doanh",
                    topTitle: "Cơ sở kinh doanh mặc định",
                    content: os.listSpa.map((element) => WidgetDropSpan(value: element)).toList(),
                    getValue: (item) => item.name ?? "Không có thông tin",
                    value: controller.dataChose,
                    onSelect: (item) => controller.dataChose = item,
                  ),
                  const SizedBox(height: 15),
                  WidgetButton(
                    title: "Đồng ý",
                    onTap: controller.onAgree,
                  )
                ],
              ),
            ),
          )
        ]
      ),
    );
  }
}
