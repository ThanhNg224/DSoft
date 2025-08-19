import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/new_pass/bloc/new_pass_bloc.dart';
import 'package:spa_project/view/new_pass/new_pass_controller.dart';

class NewPassScreen extends BaseView<NewPassController> {
  static const String router = "/NewPassScreen";
  const NewPassScreen({super.key});

  @override
  NewPassController createController(BuildContext context) => NewPassController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: BlocBuilder<NewPassBloc, NewPassState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: MyColor.white,
            appBar: const WidgetAppBar(title: "Đặt lại mật khẩu"),
            body: ListView(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: MySize.bothSides),
              physics: Utilities.defaultScroll,
              children: [
                Text("Nhập thông tin của bạn và đặt lại mật khẩu mới",
                  style: TextStyles.def.colors(MyColor.slateGray).size(18),
                ),
                const SizedBox(height: 30),
                WidgetInput(
                  tick: true,
                  validateValue: state.validatePass,
                  controller: controller.passController,
                  title: "Mật khẩu mới",
                  hintText: "Mật khẩu của bạn",
                  obscureText: !state.showPass,
                  suffixIcon: IconButton(
                    onPressed: ()=> context.read<NewPassBloc>().add(ShowNewPassEvent(
                      showPass: !state.showPass
                    )),
                    icon: Icon(state.showPass ? CupertinoIcons.eye_slash : CupertinoIcons.eye)
                  ),
                ),
                const SizedBox(height: 20),
                WidgetInput(
                  tick: true,
                  validateValue: state.validatePassConfirm,
                  controller: controller.confirmController,
                  title: "Nhập lại mật khẩu mới",
                  hintText: "Mật khẩu của bạn",
                  obscureText: !state.showPassConfirm,
                  suffixIcon: IconButton(
                      onPressed: ()=> context.read<NewPassBloc>().add(ShowNewPassEvent(
                          showPassConfirm: !state.showPassConfirm
                      )),
                      icon: Icon(state.showPassConfirm ? CupertinoIcons.eye_slash : CupertinoIcons.eye)
                  ),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(MySize.bothSides, 10, MySize.bothSides, 40),
                child: WidgetButton(
                  title: "Hoàn tất",
                  onTap: ()=> controller.onChangePass(),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}