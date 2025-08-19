import 'package:flutter/cupertino.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/custom/bloc/custom_bloc.dart';
import 'package:spa_project/view/custom/custom_controller.dart';
import 'package:spa_project/view/custom_category/custom_cate_controller.dart';
import 'package:spa_project/view/custom_category/custom_cate_screen.dart';
import 'package:spa_project/view/custom_source/custom_source_controller.dart';
import 'package:spa_project/view/custom_source/custom_source_screen.dart';

class CustomScreen extends BaseView<CustomController> {
  static const String router = "/CustomScreen";
  const CustomScreen({super.key});

  @override
  CustomController createController(BuildContext context) => CustomController(context);

  @override
  Widget zBuild() {
    return GestureDetector(
      onTap: ()=> Utilities.dismissKeyboard(),
      child: Scaffold(
        backgroundColor: MyColor.softWhite,
        appBar: WidgetAppBar(
          title: "Khách hàng", showLeading: false,
          actionIcon: BlocBuilder<CustomBloc, CustomState>(
            builder: (context, state) {
              return WidgetButton(
                iconLeading: Icons.add,
                onTap: () {
                  if(state.pageIndex == 0) {
                    controller.toCreateCustomer();
                  } else if(state.pageIndex == 1) {
                    findController<CustomCateController>().onOpenAddEditCate();
                  } else if(state.pageIndex == 2) {
                    findController<CustomSourceController>().onOpenAddEditSource();
                  }
                },
                vertical: 0,
                horizontal: 10,
              );
            }
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: BlocBuilder<CustomBloc, CustomState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: Utilities.defaultScroll,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(children: [
                      WidgetButton(
                        title: "Khách hàng",
                        color: state.pageIndex == 0 ? MyColor.green : MyColor.sliver,
                        horizontal: 20,
                        vertical: 7,
                        onTap: () {
                          context.read<CustomBloc>().add(SetPageIndexCustomEvent(0));
                        },
                      ),
                      const SizedBox(width: 20),
                      WidgetButton(
                        title: "Nhóm khách hàng",
                        horizontal: 20,
                        vertical: 7,
                        color: state.pageIndex == 1 ? MyColor.green : MyColor.sliver,
                        onTap: () {
                          context.read<CustomBloc>().add(SetPageIndexCustomEvent(1));
                        },
                      ),
                      const SizedBox(width: 20),
                      WidgetButton(
                        title: "Nguồn khách hàng",
                        horizontal: 20,
                        vertical: 7,
                        color: state.pageIndex == 2 ? MyColor.green : MyColor.sliver,
                        onTap: () {
                          context.read<CustomBloc>().add(SetPageIndexCustomEvent(2));
                        },
                      ),
                    ]),
                  );
                }
              ),
            ),
            Expanded(child: BlocBuilder<CustomBloc, CustomState>(
              builder: (context, state) {
                return _body(state);
              },
            ))
          ],
        )
      ),
    );
  }

  _body(CustomState state) {
    if(state.pageIndex == 1) {
      return const CustomCateScreen();
    } else if(state.pageIndex == 2) {
      return const CustomSourceScreen();
    } else {
      if(controller.screenStateIsOK) {
        return WidgetListView(
          onRefresh: () async => await controller.onRefresh(),
          controller: controller.scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            WidgetBoxColor(
              closed: ClosedEnd.start,
              closedBot: ClosedEnd.end,
              child: WidgetToolSearch(
                isLoading: state.isLoadingSearch,
                controller: controller.cNameFil,
                filter: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WidgetInput(
                      controller: controller.cPhoneFil,
                      title: "Số điện thoại",
                      keyboardType: TextInputType.number,
                      hintText: "Nhập số điện thoại",
                    ),
                    WidgetInput(
                      title: "Email",
                      hintText: "Nhập Email",
                      controller: controller.cEmailFil,
                    ),
                  ],
                ),
                onFilter: () => controller.onSearchData(),
                onChangeSearch: (value) => controller.onSearchData(),
              ),
            ),
            const SizedBox(height: 15),
            if(state.listCustomer.isNotEmpty || state.isLoadingSearch)
              ...List.generate(state.listCustomer.length + (controller.isMoreEnable ? 1 : 0), (index) {
                return index < state.listCustomer.length
                    ? _customItem(state, index)
                    : const WidgetLoading();
              })
            else ColoredBox(
                color: MyColor.white,
                child: Utilities.listEmpty(content: "Danh sách trống")
            ),
          ],
        );
      } else if(controller.screenStateIsError) {
        return SizedBox(
          width: double.infinity,
          child: Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.error,
                const SizedBox(height: 10),
                Utilities.retryButton(()=> controller.onGetMultiple()),
                const SizedBox(height: 10),
              ],
            ),
          )),
        );
      } else {
        return _loading();
      }
    }
  }
  
  Widget _customItem(CustomState state, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: ()=> controller.toAddEditCustomer(state.listCustomer[index]),
        child: WidgetBoxColor(
          closed: ClosedEnd.start,
          closedBot: ClosedEnd.end,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                WidgetAvatar(
                  url: state.listCustomer[index].avatar,
                  size: 30,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(state.listCustomer[index].name ?? "", style: TextStyles.def),
                    Text(state.listCustomer[index].phone ?? "", style: TextStyles.def.colors(MyColor.hideText)),
                  ]),
                )
              ]),
              const SizedBox(height: 5),
              Row(children: [
                const Icon(Icons.group_outlined),
                const SizedBox(width: 10),
                Expanded(child: Text("Nhóm khách hàng: ${state.listCustomer[index].category?.name ?? "Chưa có nhóm"}"))
              ]),
              const SizedBox(height: 5),
              if(state.listCustomer[index].source != null) Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(children: [
                  const Icon(Icons.auto_awesome_outlined),
                  const SizedBox(width: 10),
                  Expanded(child: Text("Nguồn khách hàng: ${controller.getNameSource(state.listCustomer[index].source)}"))
                ]),
              ),
              Row(children: [
                Expanded(child: WidgetButton(
                  title: "Tạo lịch",
                  iconLeading: CupertinoIcons.square_list,
                  textSize: 14,
                  styleTitle: TextStyles.def.colors(MyColor.darkNavy),
                  leadingColor: MyColor.darkNavy,
                  color: MyColor.borderInput,
                  vertical: 8,
                  onTap: () => controller.toCreateBook(state.listCustomer[index]),
                ))
              ])
            ],
          ),
        )
      ),
    );
  }

  Widget _loading() {
    return WidgetListView.builder(
      itemCount: 7,
      itemBuilder: (_, __) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 15),
          child: WidgetShimmer(
            width: double.infinity,
            height: 180,
            radius: 20,
          ),
        );
      },
    );
  }
}