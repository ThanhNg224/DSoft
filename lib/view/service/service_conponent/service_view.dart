import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_category_service.dart' as cate;
import 'package:spa_project/view/service/bloc/service_bloc.dart';
import 'package:spa_project/view/service/service_controller.dart';

mixin ServiceView {
  ServiceController get controller;
  BuildContext get context;

  Widget serviceView(ServiceState state) {
    return Column(
      children: [
        WidgetToolSearch(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          controller: controller.cNameServiceSearch,
          onChangeSearch: (value) => controller.listService.perform(),
          filter: BlocProvider.value(
            value: context.read<ServiceBloc>(),
            child: BlocBuilder<ServiceBloc, ServiceState>(
              builder: (context, state) {
                return WidgetDropDow<cate.Data>(
                  title: "Chọn nhóm dịch vụ",
                  topTitle: "Nhóm dịch vụ",
                  content: state.listCate.map((v)=> WidgetDropSpan(value: v)).toList(),
                  getValue: (value) => value.name ?? "",
                  value: state.cateSelect,
                  onSelect: (value) => context.read<ServiceBloc>().add(SetCateSelectServiceEvent(value))
                );
              }
            ),
          ),
          onFilter: ()=> controller.listService.perform(),
        ),
        const SizedBox(height: 10),
        Expanded(child: state.listService.isNotEmpty ? WidgetGridView.builder(
          onRefresh: () async => await controller.onRefresh(),
          controller: controller.scrollController,
          itemCount: state.listService.length + (controller.isMoreEnable ? 1 : 0),
          padding: const EdgeInsets.symmetric(horizontal: 20).add(const EdgeInsets.only(bottom: 30)),
          itemBuilder: (context, index) {
            return index < state.listService.length
              ? _itemService(state, index)
              : const WidgetShimmer();
          },
        ) : WidgetListView(
          onRefresh: () async => await controller.onRefresh(),
          children: [Utilities.listEmpty()]
        ))
      ],
    );
  }

  Widget _itemService(ServiceState state, int index) {
    return WidgetPopupMenu(
      name: "popup_service_$index",
      menu: [
        WidgetMenuButton(
            name: "Sửa dịch vụ",
            icon: Icons.edit,
            onTap: () => controller.onToAddEditService(index: index)
        ),
        WidgetMenuButton(
            name: "Xóa dịch vụ",
            icon: Icons.delete,
            color: MyColor.red,
            onTap: () => DeleteService().perform(index)
        )
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: MyColor.white,
          child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned.fill(child: Image.network(
                    state.listService[index].image ?? "",
                    headers: const {'Cache-Control': 'no-cache'},
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, __) {
                      debugPrint('⚠️ Image load failed: ');
                      return Image.asset(MyImage.noImage);
                    }
                )),
                IntrinsicHeight(
                  child: SizedBox(
                    width: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          gradient: LinearGradient(
                              colors: [MyColor.black.o0, MyColor.black.o7],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.8]
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(state.listService[index].name ?? "Đang cập nhật",
                              style: TextStyles.def.bold.colors(MyColor.white).size(14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("đ${(state.listService[index].price ?? 0).toCurrency()}",
                              style: TextStyles.def.bold.colors(MyColor.white).size(12),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ]
          ),
        ),
      ),
    );
  }

}