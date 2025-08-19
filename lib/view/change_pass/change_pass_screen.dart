import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/change_pass/change_pass_controller.dart';
import 'package:spa_project/view/change_pass/change_pass_cubit.dart';

class ChangePassScreen extends BaseView<ChangePassController> {
  static const String router = "/ChangePassScreen";
  const ChangePassScreen({super.key});

  @override
  ChangePassController createController(BuildContext context) => ChangePassController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: BlocBuilder<ChangePassCubit, ChangePassState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.softWhite,
            appBar: const WidgetAppBar(title: "Đổi mật khẩu"),
            body: WidgetListView(
              children: [
                WidgetInput(
                  title: "Mật khẩu cũ",
                  hintText: "Nhập mật khẩu cũ",
                  controller: controller.cPassOld,
                  obscureText: !state.showPass,
                  validateValue: state.vaPass,
                  suffixIcon: IconButton(
                    onPressed: context.read<ChangePassCubit>().showPassEvent,
                    icon: Icon(!state.showPass ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill)
                  ),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  title: "Mật khẩu mới",
                  hintText: "Nhập mật khẩu mới",
                  controller: controller.cPassNew,
                  obscureText: !state.showPassNew,
                  validateValue: state.vaPassNew,
                  suffixIcon: IconButton(
                    onPressed: context.read<ChangePassCubit>().showPassNewEvent,
                    icon: Icon(!state.showPassNew ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill)
                  ),
                ),
                const SizedBox(height: 10),
                WidgetInput(
                  title: "Nhập lại mật khẩu",
                  hintText: "Nhập lại mật khẩu mới",
                  controller: controller.cPassConfirm,
                  obscureText: !state.showPassConfirm,
                  validateValue: state.vaPassConfirm,
                  suffixIcon: IconButton(
                    onPressed: context.read<ChangePassCubit>().showPassConfirmEvent,
                    icon: Icon(!state.showPassConfirm ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill)
                  ),
                )
              ]
            ),
            bottomNavigationBar: SizedBox(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
                child: WidgetButton(
                  title: "Thay đổi mật khẩu",
                  vertical: 0,
                  onTap: controller.onChangePass,
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}