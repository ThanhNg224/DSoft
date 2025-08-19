import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/change_my_info/change_my_info_screen.dart';
import 'package:spa_project/view/change_pass/change_pass_screen.dart';
import 'package:spa_project/view/profile/profile_controller.dart';

class ProfileScreen extends BaseView<ProfileController> {
  static const String router = "/ProfileScreen";
  final ConfettiController confettiController;
  const ProfileScreen({super.key, required this.confettiController});

  @override
  ProfileController createController(BuildContext context) => ProfileController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: const WidgetAppBar(
        title: "Cá nhân",
        backgroundColor: MyColor.slateBlue,
        colorTitle: MyColor.white,
        showLeading: false,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              const SizedBox(height: 10),
              Utilities.retryButton(()=> controller.getMyInfo.perform()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return Column(children: [
        ColoredBox(
            color: MyColor.slateBlue,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(children: [
                WidgetAvatar(
                  url: os.modelMyInfo?.data?.avatar,
                  size: 70,
                ),
                const SizedBox(width: 20),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(os.modelMyInfo?.data?.name ?? "", style: TextStyles.def.colors(MyColor.white).bold.size(20)),
                    Text(os.modelMyInfo?.data?.phone ?? "", style: TextStyles.def.colors(MyColor.white).semiBold),
                    if(Global.getInt(Constant.deadline) != 0) Text("Ngày hết hạn: ${Global.getInt(Constant.deadline).formatUnixTimeToDateDDMMYYYY()}",
                        style: TextStyles.def.colors(MyColor.white).semiBold.size(12)),
                  ],
                ))
              ]),
            )
        ),
        Expanded(child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [MyColor.darkNavy, MyColor.darkNavy.o1, MyColor.nowhere],
              stops: const [0.0, 0.95, 1.0],
            ).createShader(Rect.fromLTRB(0, rect.height * 0.85, rect.width, rect.height));
          },
          blendMode: BlendMode.dstIn,
          child: WidgetListView(
            children: [
              _itemTile(
                  text: "Đổi mật khẩu",
                  icon: const Icon(Icons.lock),
                  onTap: ()=> Navigator.pushNamed(context, ChangePassScreen.router)
              ),
              _itemTile(
                  text: "Sửa thông tin",
                  icon: const Icon(Icons.person),
                  onTap: ()=> Navigator.pushNamed(context, ChangeMyInfoScreen.router)
              ),
              _itemTile(
                 text: "Gia hạn tài khoản",
                 icon: SvgPicture.asset(MyImage.iconPayment),
                 onTap: () => controller.toSubscriptionScreen(confettiController),
              ),
              _itemTile(
                 text: "Cơ sở kinh doanh mặc định",
                 icon: const Icon(Icons.spa_outlined),
                 onTap: () => controller.openSpaDefault(os),
              ),
              _itemTile(
                  text: "Xóa tài khoản",
                  icon: const Icon(Icons.group_remove_sharp, color: MyColor.red),
                  onTap: controller.removeAccount.perform,
                  style: TextStyles.def.colors(MyColor.red)
              ),
            ],
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: WidgetButton(
            title: "Đăng xuất",
            color: MyColor.red.o2,
            styleTitle: TextStyles.def.colors(MyColor.red),
            onTap: controller.logOut.perform,
          ),
        )
      ]);
    }
  }

  Widget _itemTile({required Widget icon, required String text, required Function() onTap, TextStyle? style}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Material(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 12),
                Expanded(child: Text(text, style: style ?? TextStyles.def, maxLines: 1, overflow: TextOverflow.ellipsis)),
                const Icon(Icons.arrow_forward_ios_rounded, size: 15)
              ],
            ),
          ),
        ),
      ),
    );
  }

}
