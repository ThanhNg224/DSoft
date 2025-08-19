import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/forgot_password/forgot_password_screen.dart';
import 'package:spa_project/view/login/bloc/login_bloc.dart';
import 'package:spa_project/view/login/login_controller.dart';
import 'package:spa_project/view/register/register_screen.dart';

class LoginScreen extends BaseView<LoginController> {
  static const String router = '/LoginScreen';
  const LoginScreen({super.key});

  @override
  LoginController createController(BuildContext context)=> LoginController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: ()=> Utilities.dismissKeyboard(),
          child: SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: MyColor.white,
              body: ListView(
                padding: const EdgeInsets.symmetric(horizontal: MySize.bothSides),
                physics: Utilities.defaultScroll,
                controller: controller.scrollLoginController,
                children: [
                  SizedBox(height: Utilities.screen(context).h*0.1),
                  Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Image.asset(MyImage.iconFavourite, height: 33, width: 33),
                    const SizedBox(width: 10),
                    Text("DSOFT", style: TextStyles.def.bold.size(24)),
                  ])),
                  const SizedBox(height: 25),
                  Center(child: Text("Đăng nhập tại đây", style: TextStyles.def.bold.size(24))),
                  const SizedBox(height: 25),
                  WidgetInput(
                    controller: controller.cNumber,
                    title: "Số điện thoại",
                    validateValue: state.validateNumber,
                    hintText: "Nhập số điện thoại",
                    tick: true,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  WidgetInput(
                    controller: controller.cPassWork,
                    title: "Mất khẩu",
                    validateValue: state.validatePassword,
                    hintText: "Nhập mất khẩu",
                    obscureText: !state.isShowPassWork,
                    suffixIcon: IconButton(
                      onPressed: ()=> controller.onShowPassWord.perform(state.isShowPassWork),
                      icon: Icon(state.isShowPassWork ? CupertinoIcons.eye_slash : CupertinoIcons.eye)
                    ),
                    tick: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(children: [
                      WidgetCheckbox(
                        value: state.rememberMe,
                        onChanged: (value) => context.read<LoginBloc>().add(RememberMeLoginEvent(value!)),
                      ),
                      Expanded(child: GestureDetector(
                        onTap: ()=> context.read<LoginBloc>().add(RememberMeLoginEvent(!state.rememberMe)),
                        child: Text("Ghi nhớ tôi", style: TextStyles.def.colors(MyColor.slateGray).medium))
                      ),
                      Expanded(child: GestureDetector(
                        onTap: ()=> Navigator.pushNamed(context, ForgotPasswordScreen.router),
                        child: Text("Quên mật khẩu?",
                          style: TextStyles.def.colors(MyColor.slateBlue).semiBold,
                          textAlign: TextAlign.end,
                        ),
                      )),
                    ]),
                  ),
                  WidgetButton(
                    title: "Đăng nhập",
                    onTap: ()=> controller.onLogin(controller.cNumber.text, controller.cPassWork.text)
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: ()=> Navigator.pushNamed(context, RegisterScreen.router),
                    child: Material(
                      color: MyColor.nowhere,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(textAlign: TextAlign.center, text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Bạn chưa có tài khoản?",
                              style: TextStyles.def.medium.colors(MyColor.hideText),
                            ),
                            TextSpan(
                              text: " Đăng ký tài khoản mới",
                              style: TextStyles.def.bold.colors(MyColor.green),
                            )
                          ]
                        )),
                      ),
                    ),
                  )
                ]
              ),
              bottomNavigationBar: IntrinsicHeight(
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(begin: 0, end: state.scrolling ? 8 : 0),
                  builder: (context, value, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: MyColor.white,
                            boxShadow: [BoxShadow(
                                blurRadius: value,
                                color: MyColor.hideText.o2,
                                offset: Offset(0, -value)
                            )]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                          child: Column(children: [
                            Text("Terms & Conditions  ·  Privacy Policy", style: TextStyles.def),
                            const SizedBox(height: 10),
                            Text("© 2025 DSOFT . PHOENIX TECH.", style: TextStyles.def.colors(MyColor.hideText)),
                          ]),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        );
      }
    );
  }

}