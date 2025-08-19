import 'package:spa_project/base_project/package.dart';

import 'debt_payment_controller.dart';

class DebtPaymentScreen extends BaseView<DebtPaymentController> {
  static const String router = "/DebtManagementAddScreen";
  const DebtPaymentScreen({super.key});

  @override
  DebtPaymentController createController(BuildContext context)
  => DebtPaymentController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: WidgetAppBar(title: "title"),
    );
  }
}