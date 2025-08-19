import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/spa/bloc/spa_bloc.dart';
import 'package:spa_project/view/spa/spa_controller.dart';
import 'package:spa_project/view/spa_add_edit/spa_add_edit_screen.dart';

class SpaScreen extends BaseView<SpaController> {
  static const String router = "/SpaScreen";
  const SpaScreen({super.key});

  @override
  SpaController createController(BuildContext context) => SpaController(context);

  @override
  Widget zBuild() {
    print(Global.getInt(Constant.numberSpa));
    return BlocBuilder<SpaBloc, SpaState>(
        builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Cơ sở kinh doanh",
            actionIcon: Global.getInt(Constant.numberSpa) > state.listSpa.length ? WidgetButton(
              iconLeading: Icons.add,
              horizontal: 10,
              vertical: 0,
              onTap: ()=> Navigator.pushNamed(context, SpaAddEditScreen.router),
            ) : const SizedBox(),
          ),
          body: _body(),
        );
      }
    );
  }

  Widget _body() {
    if(controller.screenStateIsLoading) {
      return _loading();
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorView,
                const SizedBox(height: 10),
                SizedBox(
                  width: 120,
                  child: WidgetButton(
                    vertical: 7,
                    title: "Thử lại",
                    onTap: ()=> controller.getListSpa(true),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return BlocBuilder<SpaBloc, SpaState>(
        builder: (context, state) {
          return WidgetListView.builder(
            itemCount: state.listSpa.length,
            onRefresh: () async => controller.getListSpa(false),
            itemBuilder: (context, index) {
              var data = state.listSpa[index];
              return GestureDetector(
                onTap: ()=> controller.toDetail(state, index),
                child: Column(
                  children: [
                    WidgetBoxColor(
                      closed: ClosedEnd.start,
                      closedBot: ClosedEnd.end,
                      child: Row(children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(data.name ?? "Đang cập nhật", style: TextStyles.def.bold.size(20)),
                            Text(data.email ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.hideText)),
                            Text(data.phone ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.hideText)),
                            Text(data.address ?? "Đang cập nhật", style: TextStyles.def.colors(MyColor.hideText)),
                          ]),
                        )
                      ])
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          );
        }
      );
    }
  }

  Widget _loading() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(children: List.generate(6, (index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 40 : 20, left: 20, right: 20),
          child: const WidgetShimmer(
            height: 170,
            width: double.infinity,
            radius: 20,
          ),
        );
      })),
    );
  }
}