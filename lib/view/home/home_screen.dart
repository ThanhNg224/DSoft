import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/debt_management/debt_management_screen.dart';
import 'package:spa_project/view/diagram_room_bed/diagram_room_bed_screen.dart';
import 'package:spa_project/view/home/bloc/home_bloc.dart';
import 'package:spa_project/view/multi_view/multi_view_controller.dart';
import 'package:spa_project/view/order/order_screen.dart';
import 'package:spa_project/view/statistical/statistical_screen.dart';

import '../book_detail/book_detail_screen.dart';
import 'component_home.dart';

class HomeScreen extends BaseView<HomeController> {
  static const String router = '/HomeScreen';
  const HomeScreen({super.key});

  @override
  HomeController createController(BuildContext context)=> HomeController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "",
            backgroundColor: MyColor.slateBlue,
            leading: GestureDetector(
              onTap: ()=> MultiViewController.open(),
              child: Center(child: SvgPicture.asset(MyImage.iconMenu, height: 29, width: 29))
            ),
            actionIcon: _trailing(),
          ),
          body: Stack(
            children: [
              const SizedBox(
                height: 260,
                width: double.infinity,
                child: ColoredBox(color: MyColor.slateBlue),
              ),
              WidgetListView(
                onRefresh: () async => controller.onRefresh(),
                onRefreshColor: MyColor.white,
                children: [
                  Text("Xin chào, ${os.modelMyInfo?.data?.name?.removeString("(chủ)") ?? ""}", style: TextStyles.def.bold.colors(MyColor.white).size(24)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text("Chào mừng bạn quay trở lại", style: TextStyles.def.colors(MyColor.white)),
                  ),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          MyColor.nowhere,
                          MyColor.white.o3,
                          MyColor.nowhere
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(
                        color: Colors.white,
                        thickness: 1.3,
                        height: 1,
                      ),
                    ),
                  ),
                  _listBtn(state),
                  const SizedBox(height: 20),
                  state.page == 0 ? _itemBusinessReport(state) : _monthlyRevenueView(state)
                ]
              )
            ],
          ),
        );
      }
    );
  }

  Widget _trailing() {
    return WidgetPopupMenu(
      name: "avatar",
      menu: const [
        // WidgetMenuButton(name: "name", onTap: () {}, icon: Icons.add),
        // WidgetMenuButton(name: "name", onTap: () {}, icon: Icons.add),
      ],
      child: WidgetAvatar(url: os.modelMyInfo?.data?.avatar)
    );
  }

  Widget _itemBusinessReport(HomeState state) {
    var dataReport = state.report?.data;
    var dataBook = state.listBook?.data ?? [];
    if(controller.screenStateIsLoading) {
      return ComponentHome.loadBusinessReport();
    } else if (controller.screenStateIsError) {
      return controller.error;
    } else {
      return WidgetBoxColor(
        closed: ClosedEnd.start,
        closedBot: ClosedEnd.end,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          DecoratedBox(
            decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(
                  color: MyColor.darkNavy.o1,
                  blurRadius: 10,
                )]
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Row(children: [
                _itemMenu(CupertinoIcons.square_stack_3d_up_fill, "Sơ đồ", ()=> Navigator.pushNamed(context, DiagramRoomBedScreen.router)),
                _itemMenu(Icons.payments, "Sổ quỹ", ()=> Navigator.pushNamed(context, DebtManagementScreen.router)),
                _itemMenu(CupertinoIcons.cube_box_fill, "Đơn hàng", ()=> Navigator.pushNamed(context, OrderScreen.router)),
                _itemMenu(CupertinoIcons.chart_bar_square_fill, "Thống kê", ()=> Navigator.pushNamed(context, StatisticalScreen.router)),
              ]),
            ),
          ),
          const SizedBox(height: 20),
          IntrinsicHeight(
            child: Row(children: [
              Expanded(child: _boxWhiteShadow("Số đơn sản phẩm", dataReport?.totalOrderproduct)),
              const SizedBox(width: 10),
              Expanded(child: _boxWhiteShadow("Số dịch vụ", dataReport?.totalOrderService)),
            ]),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(children: [
              Expanded(child: _boxWhiteShadow("Số Combo", dataReport?.totalOrderCombo)),
              const SizedBox(width: 10),
              Expanded(child: _boxWhiteShadow("Số khách đặt lịch hẹn", dataReport?.totalbook)),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text("Khách mới hôm nay", style: TextStyles.def.bold),
          ),
          if(dataBook.isNotEmpty)
            ...List.generate(dataBook.length >= 5 ? 5 : dataBook.length, (index) {
              return GestureDetector(
                onTap: () => Navigator.pushNamed(context, BookDetailScreen.router, arguments: dataBook[index].id),
                child: WidgetCustomerReservation(
                  day: (dataBook[index].timeBook?.formatUnixTimeToDateDDMMYYYY()).toString(),
                  status: WidgetCustomerReservation.decode(dataBook[index].status),
                  avatar: dataBook[index].avatar ?? "",
                  name: dataBook[index].name ?? "Đang cập nhật",
                  numberPhone: dataBook[index].phone ?? "Đang cập nhật",
                  nameService: dataBook[index].service?.name,
                ),
              );
            })
          else
            Center(child: Utilities.listEmpty())
        ]),
      );
    }
  }

  Widget _monthlyRevenueView(HomeState state) {
    double totalValue = state.listBilStatistical.fold(0.0, (sum, item) => sum + (item.value as num).toDouble());
    if(controller.screenStateIsLoading) return ComponentHome.loadBilStatistical();
    return WidgetBoxColor(
      closedBot: ClosedEnd.end,
      closed: ClosedEnd.start,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(
              children: [
                TextSpan(
                    text: "Tổng doanh thu: ",
                    style: TextStyles.def.size(16)
                ),
                TextSpan(
                    text: "${totalValue.toCurrency()}đ",
                    style: TextStyles.def.size(16).bold.colors(MyColor.slateBlue)
                )
              ]
          )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(children: [
              const ClipOval(
                child: SizedBox(
                  height: 10,
                  width: 10,
                  child: ColoredBox(color: MyColor.slateBlue),
                ),
              ),
              Expanded(child: Text("  Biểu thị 1", style: TextStyles.def.size(10).bold))
            ]),
          ),
          if(state.listBilStatistical.isNotEmpty)
          WidgetChart(list: List.generate(state.listBilStatistical.length, (index) {
            var list = state.listBilStatistical[index];
            return WidgetChartItem(list.value ?? 0, list.time ?? 0);
          }))
          else Center(child: Utilities.listEmpty(content: "Không có dữ liệu"))
        ],
      ),
    );
  }

  Widget _boxWhiteShadow(String title, int? value) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: MyColor.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(
          color: MyColor.darkNavy.o1,
          blurRadius: 10,
        )]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(title, style: TextStyles.def.bold),
            const Spacer(),
            Text((value ?? 0).toString(), style: TextStyles.def.bold.size(32))
          ],
        ),
      ),
    );
  }

  Widget _itemMenu(IconData icon, String title, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            children: [
              Icon(icon, size: 33, color: MyColor.slateBlue),
              Text(title, style: TextStyles.def.size(11), textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }

  Widget _listBtn(HomeState state) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: Utilities.defaultScroll,
      child: Row(children: [
        WidgetButton(
          title: "Thống kê hôm nay",
          styleTitle: TextStyles.def.colors(state.page == 0 ? MyColor.darkNavy : MyColor.white),
          color: state.page == 0 ? MyColor.white : MyColor.nowhere,
          horizontal: 10,
          vertical: 8,
          onTap: ()=> context.read<HomeBloc>().add(ChangePageHomeEvent(0)),
        ),
        const SizedBox(width: 15),
        WidgetButton(
          title: "Doanh thu theo tháng",
          styleTitle: TextStyles.def.colors(state.page == 1 ? MyColor.darkNavy : MyColor.white),
          color: state.page == 1 ? MyColor.white : MyColor.nowhere,
          horizontal: 10,
          vertical: 8,
          onTap: ()=> context.read<HomeBloc>().add(ChangePageHomeEvent(1)),
        ),
      ])
    );
  }
}
