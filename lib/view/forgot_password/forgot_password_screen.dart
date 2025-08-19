import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/forgot_password/forgot_password_controller.dart';

import 'forgot_pass_cubit.dart';

class ForgotPasswordScreen extends BaseView<ForgotPasswordController> {
  static const String router = "/ForgotPasswordScreen";
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordController createController(BuildContext context) => ForgotPasswordController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: BlocBuilder<ForgotPassCubit, String>(
          builder: (context, validate) {
            return Scaffold(
              backgroundColor: MyColor.white,
              appBar: const WidgetAppBar(title: "Đặt lại mật khẩu"),
              resizeToAvoidBottomInset: false,
              body: ListView(
                physics: Utilities.defaultScroll,
                padding: const EdgeInsets.symmetric(horizontal: MySize.bothSides, vertical: 30),
                children: [
                  Text("Nhập thông tin của bạn và đặt lại mật khẩu mới",
                      style: TextStyles.def.colors(MyColor.slateGray).size(18)),
                  const SizedBox(height: 20),
                  WidgetInput(
                    title: "Số điện thoại đã xác thực",
                    controller: controller.numberController,
                    tick: true,
                    keyboardType: TextInputType.number,
                    hintText: "Số điện thoại của bạn",
                    validateValue: validate,
                  )
                ],
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: ()=> Navigator.pop(context),
                    child: Material(
                      color: MyColor.nowhere,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: RichText(text: TextSpan(children: [
                          TextSpan(
                              text: "Bạn đã có tài khoản? ",
                              style: TextStyles.def.colors(MyColor.slateGray)
                          ),
                          TextSpan(
                              text: "Đăng nhập ngay",
                              style: TextStyles.def.colors(MyColor.green).semiBold
                          )
                        ])),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(MySize.bothSides, 10, MySize.bothSides, 40),
                      child: WidgetButton(
                        title: "Nhận mã xác nhận",
                        onTap: ()=> controller.nexPage(),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
      ),
    );
  }

}