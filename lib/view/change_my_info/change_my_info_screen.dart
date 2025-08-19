import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/change_my_info/change_my_info_controller.dart';
import 'package:spa_project/view/change_my_info/change_my_info_cubit.dart';

class ChangeMyInfoScreen extends BaseView<ChangeMyInfoController> {
  static const String router = "/ChangeMyInfoScreen";
  const ChangeMyInfoScreen({super.key});

  @override
  ChangeMyInfoController createController(BuildContext context) => ChangeMyInfoController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<ChangeMyInfoCubit, String>(
      builder: (context, fileAvatar) {
        return GestureDetector(
          onTap: ()=> Utilities.dismissKeyboard(),
          child: Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: const WidgetAppBar(title: "Sửa thông tin"),
            body: WidgetListView(
              children: [
                _boxWhite(
                  child: Center(
                    child: GestureDetector(
                      onTap: controller.onAvatarPicker,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          WidgetAvatar(
                            size: 180,
                            url: fileAvatar.isEmpty ? os.modelMyInfo?.data?.avatar : fileAvatar,
                          ),
                          Transform.translate(
                            offset: const Offset(0, -10),
                            child: Utilities.iconCamera(size: 30)
                          )
                        ],
                      ),
                    ),
                  ),
                  top: 20,
                  padTop: 20
                ),
                _boxWhite(child: WidgetInput(
                    title: "Tên SPA",
                    hintText: "Nhập tên SPA",
                    controller: controller.cName,
                )),
                _boxWhite(child: WidgetInput(
                  title: "Số điện thoại",
                  hintText: "Nhập Số điện thoại",
                  controller: controller.cPhone,
                  enabled: false,
                )),
                _boxWhite(child: WidgetInput(
                  title: "Email",
                  hintText: "Nhập email",
                  controller: controller.cEmail,
                )),
                _boxWhite(
                  child: WidgetInput(
                    title: "Địa chỉ",
                    hintText: "Nhập địa chỉ",
                    controller: controller.cAddress,
                  ),
                  padBot: 50,
                  bottom: 20
                )
              ]
            ),
            bottomNavigationBar: SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: WidgetButton(
                  title: "Cập nhật",
                  vertical: 0,
                  onTap: controller.onChange,
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _boxWhite({required Widget child,
    double top = 0,
    double bottom = 0,
    double padTop = 10,
    double padBot = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(top),
        bottom: Radius.circular(bottom),
      ),
      child: ColoredBox(
        color: MyColor.white,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: padTop, bottom: padBot),
          child: child,
        ),
      ),
    );
  }
}