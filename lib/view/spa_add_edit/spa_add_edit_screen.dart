import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/spa_add_edit/bloc/spa_add_edit_bloc.dart';
import 'package:spa_project/view/spa_add_edit/spa_add_edit_controller.dart';

class SpaAddEditScreen extends BaseView<SpaAddEditController> {
  static const String router = "/SpaAddEditScreen";
  const SpaAddEditScreen({super.key});

  @override
  SpaAddEditController createController(BuildContext context)
  => SpaAddEditController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: BlocBuilder<SpaAddEditBloc, SpaAddEditState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: WidgetAppBar(title: state.titleAppBar),
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
                    title: "Tên Spa",
                    tick: true,
                    hintText: "Nhập tên Spa",
                    controller: controller.cName,
                    validateValue: state.vaNameSpa,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Số điện thoại",
                    tick: true,
                    hintText: "Nhập số điện thoại",
                    controller: controller.cPhone,
                    validateValue: state.vaPhone,
                    keyboardType: TextInputType.number,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Địa chỉ",
                    tick: true,
                    hintText: "Nhập địa chỉ",
                    controller: controller.cAddress,
                    validateValue: state.vaAddress,
                  )
                ),
                WidgetBoxColor(
                  child: WidgetInput(
                    title: "Email",
                    hintText: "Nhập email",
                    controller: controller.cEmail,
                  )
                ),
                WidgetBoxColor(
                  closedBot: ClosedEnd.end,
                  child: WidgetInput(
                    title: "Ghi chú",
                    hintText: "Nhập ghi chú",
                    maxLines: 3,
                    controller: controller.cNote,
                  )
                ),
                const SizedBox(height: 10),
                Row(children: [
                  const Expanded(child: Divider(color: MyColor.sliver, endIndent: 20)),
                  Text("Liên kết", style: TextStyles.def.bold),
                  const Expanded(child: Divider(color: MyColor.sliver, indent: 20)),
                ]),
                const SizedBox(height: 10),
                WidgetBoxColor(
                  closed: ClosedEnd.start,
                  child: Row(
                    children: [
                      const Icon(Icons.facebook, color: Colors.blue),
                      const SizedBox(width: 10),
                      Expanded(
                        child: WidgetInput(
                          hintText: "Nhập liên kết facebook",
                          controller: controller.cFaceBook,
                        ),
                      ),
                    ],
                  )
                ),
                WidgetBoxColor(
                  closedBot: ClosedEnd.end,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Image.asset(MyImage.iconZalo, width: 20, height: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: WidgetInput(
                          hintText: "Nhập liên kết zalo",
                          controller: controller.cZalo,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                ),
              ]
            ),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                child: WidgetButton(
                  title: state.titleBtn,
                  vertical: 0,
                  onTap: controller.onUpdateData,
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _boxImage(SpaAddEditState state) {
    return GestureDetector(
      onTap: controller.onChoseImage,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MyColor.borderInput
        ),
        child: Center(
          child: WidgetImage(
            imageUrl: state.image,
            width: double.infinity,
            errorImage: const Icon(
              Icons.add,
              color: MyColor.sliver,
              size: 80,
            )
          ),
        ),
      ),
    );
  }

}
