import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_prepaid_card.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_controller.dart';
import 'package:spa_project/view/prepaid_card/prepaid_card_cubit.dart';

class PrepaidCardScreen extends BaseView<PrepaidCardController> {
  static const String router = "/PrepaidCardScreen";
  const PrepaidCardScreen({super.key});

  @override
  PrepaidCardController createController(BuildContext context)
  => PrepaidCardController(context);

  @override
  Widget zBuild() {
    return Scaffold(
      backgroundColor: MyColor.softWhite,
      appBar: WidgetAppBar(
        title: "Thẻ trả trước",
        actionIcon: WidgetButton(
          iconLeading: Icons.add,
          onTap: controller.toAddPrepaidCard,
          vertical: 0,
          horizontal: 10,
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return WidgetListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: WidgetShimmer(
              width: double.infinity,
              height: 220,
            ),
          );
        },
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              controller.errorWidget,
              const SizedBox(height: 10),
              Utilities.retryButton(()=> controller.getPrepaidCard()),
              const SizedBox(height: 10),
            ],
          ),
        )),
      );
    } else {
      return BlocBuilder<PrepaidCardCubit, List<Data>>(
        builder: (context, state) {
          if(state.isEmpty) {
            return WidgetListView(
              onRefresh: () async => controller.getPrepaidCard(),
              children: [Utilities.listEmpty()],
            );
          }
          return WidgetListView.builder(
            onRefresh: () async => controller.getPrepaidCard(isLoad: false),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: GestureDetector(
                  onTap: ()=> controller.toAddPrepaidCard(data: state[index]),
                  child: WidgetBoxColor(
                      closed: ClosedEnd.start,
                      closedBot: ClosedEnd.end,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state[index].name ?? "Đang cập nhật",
                            style: TextStyles.def.bold.size(17),
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const SizedBox(
                                  width: 5,
                                  child: ColoredBox(color: MyColor.slateBlue),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _infoCount(title: "Giá bán:", data: "${state[index].price?.toCurrency(suffix: "đ")}"),
                                      _infoCount(title: "Mệnh giá sử dụng:", data: "${state[index].priceSell?.toCurrency(suffix: "đ")}"),
                                      _infoCount(title: "Thời hạn:", data: "${state[index].useTime} ngày"),
                                      _infoCount(title: "Trạng thái:", data: state[index].status == "active" ? "Hoạt động" : "Không hoạt động"),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  Widget _infoCount({required String title, required String data}) {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(title, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
        Expanded(child: Divider(height: 10, indent: 5, endIndent: 5, color: MyColor.sliver.o3)),
        Text(data, style: TextStyles.def.size(12).colors(MyColor.slateGray)),
      ]),
    );
  }


}