import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_debt_collection.dart';
import 'package:spa_project/view/debt_management/bill_collect/bill_collect_screen.dart';
import 'package:spa_project/view/debt_management/bill_collect_add/bill_collect_add_screen.dart';
import 'package:spa_project/view/debt_management/bill_spend/bill_spend_screen.dart';
import 'package:spa_project/view/debt_management/bill_spend_add/bill_spend_add_screen.dart';
import 'package:spa_project/view/debt_management/debt_add_collection/debt_add_collection_screen.dart';
import 'package:spa_project/view/debt_management/debt_collection/debt_collection_screen.dart';
import 'package:spa_project/view/debt_management/debt_management_cubit.dart';
import 'package:spa_project/view/debt_management/debt_paid/debt_paid_screen.dart';

class DebtManagementScreen extends StatelessWidget {
  static const String router = "/DebtManagementScreen";
  const DebtManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtManagementCubit, DebtManagementState>(
      builder: (_, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Quản lý công nợ",
            actionIcon: WidgetButton(
              iconLeading: Icons.add,
              onTap: () {
                if(state.pageIndex == 2) {
                  Navigator.pushNamed(context, DebtAddCollectionScreen.router, arguments: DebtManagementSend());
                } else if(state.pageIndex == 3) {
                  Navigator.pushNamed(context, DebtAddCollectionScreen.router,
                      arguments: DebtManagementSend(isCollectionDebt: false));
                } else if(state.pageIndex == 0) {
                  Navigator.pushNamed(context, BillCollectAddScreen.router);
                } else if(state.pageIndex == 1) {
                  Navigator.pushNamed(context, BillSpendAddScreen.router);
                }
              },
              vertical: 0,
              horizontal: 10,
            ),
          ),
          body: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: Utilities.defaultScroll,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(children: [
                    WidgetButton(
                      title: "Phiếu thu",
                      color: state.pageIndex == 0 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () {
                        context.read<DebtManagementCubit>().changePageDebtManagement(0);
                      },
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Phiếu chi",
                      color: state.pageIndex == 1 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () {
                        context.read<DebtManagementCubit>().changePageDebtManagement(1);
                      },
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Công nợ phải thu",
                      color: state.pageIndex == 2 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () {
                        context.read<DebtManagementCubit>().changePageDebtManagement(2);
                      },
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Công nợ phải trả",
                      horizontal: 20,
                      vertical: 7,
                      color: state.pageIndex == 3 ? MyColor.green : MyColor.sliver,
                      onTap: () {
                        context.read<DebtManagementCubit>().changePageDebtManagement(3);
                      },
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(child: _listView(state)[state.pageIndex]),
            ],
          ),
        );
      }
    );
  }

  List<Widget> _listView(DebtManagementState state) => [
    BillCollectScreen(state: state),
    BillSpendScreen(state: state),
    DebtCollectionScreen(state: state),
    DebtPaidScreen(state: state)
  ];
}

class DebtManagementSend {
  bool isCollectionDebt;
  Data? data;

  DebtManagementSend({
    this.isCollectionDebt = true,
    this.data
  });
}
