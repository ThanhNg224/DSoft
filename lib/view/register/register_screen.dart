import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/register/bloc/register_bloc.dart';
import 'package:spa_project/view/register/register_controller.dart';

class RegisterScreen extends BaseView<RegisterController> {
  static const String router = "/RegisterScreen";
  const RegisterScreen({super.key});

  @override
  RegisterController createController(BuildContext context) => RegisterController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: Scaffold(
        backgroundColor: MyColor.white,
        appBar: const WidgetAppBar(title: "Đăng ký"),
        body: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return ListView(
              physics: Utilities.defaultScroll,
              padding: const EdgeInsets.symmetric(horizontal: MySize.bothSides, vertical: 20),
              children: [
                RichText(text: TextSpan(children: [
                  TextSpan(
                    text: "Phần mềm quản lý DSOFT",
                    style: TextStyles.def.size(32).bold
                  ),
                  WidgetSpan(child: Image.asset(MyImage.iconFavourite, width: 32, height: 32))
                ])),
                const SizedBox(height: 8),
                Text("Đăng ký sử dụng phần mềm quản lý SPA", style: TextStyles.def.size(18).regular.colors(MyColor.slateGray)),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Tên SPA",
                  tick: true,
                  hintText: "Nhập tên SPA bạn muốn tạo",
                  controller: controller.tNameSpa,
                  validateValue: state.vaName,
                ),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Số điện thoại",
                  tick: true,
                  keyboardType: TextInputType.number,
                  hintText: "Số điện thoại của bạn",
                  controller: controller.tNumber,
                  validateValue: state.vaPhone,
                ),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Địa chỉ",
                  hintText: "Địa chỉ của bạn",
                  controller: controller.tAddress,
                ),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Email",
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Địa chỉ Email của bạn",
                  controller: controller.tEmail,
                ),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Mật khẩu",
                  tick: true,
                  hintText: "Mật khẩu của bạn",
                  obscureText: !state.isShowPass,
                  suffixIcon: IconButton(
                    onPressed: () => onTriggerEvent<RegisterBloc>().add(HideShowPassRegisterEvent(isShowPass: !state.isShowPass)),
                    icon: Icon(state.isShowPass ? CupertinoIcons.eye_slash : CupertinoIcons.eye)
                  ),
                  validateValue: state.vaPass,
                  controller: controller.tPassWord,
                ),
                const SizedBox(height: 8),
                WidgetInput(
                  title: "Nhập lại mật khẩu",
                  tick: true,
                  hintText: "Nhập lại mật khẩu của bạn",
                  obscureText: !state.isShowConfirm,
                  controller: controller.tConfirmPass,
                  suffixIcon: IconButton(
                    onPressed: () => onTriggerEvent<RegisterBloc>().add(HideShowPassRegisterEvent(isShowConfirm: !state.isShowConfirm)),
                    icon: Icon(state.isShowConfirm ? CupertinoIcons.eye_slash : CupertinoIcons.eye)
                  ),
                  validateValue: state.vaPassConfirm,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: WidgetButton(
                    title: "Tạo tài khoản",
                    onTap: ()=> controller.perform()
                  ),
                ),
                GestureDetector(
                  onTap: ()=> Navigator.pop(context),
                  child: Material(
                    color: MyColor.nowhere,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RichText(textAlign: TextAlign.center, text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Bạn đã có tài khoản? ",
                            style: TextStyles.def.medium.colors(MyColor.hideText),
                          ),
                          TextSpan(
                            text: " Đăng nhập ngay",
                            style: TextStyles.def.bold.colors(MyColor.green),
                          )
                        ]
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ]
            );
          }
        ),
      ),
    );
  }

}