import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/view/bed_room/bed_room_component/bed_view.dart';
import 'package:spa_project/view/bed_room/bed_room_component/room_view.dart';
import 'package:spa_project/view/bed_room/bed_room_controller.dart';
import 'package:spa_project/view/bed_room/bloc/bed_room_bloc.dart';

class BedRoomScreen extends BaseView<BedRoomController> with RoomView, BedView {
  static const String router = "/BedRoomScreen";
  const BedRoomScreen({super.key});

  @override
  BedRoomController createController(BuildContext context)
  => BedRoomController(context);

  @override
  Widget zBuild() {
    return BlocBuilder<BedRoomBloc, BedRoomState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyColor.softWhite,
          appBar: WidgetAppBar(
            title: "Phòng & giường",
            actionIcon: WidgetButton(
              title: "",
              iconLeading: Icons.add,
              vertical: 0,
              horizontal: 10,
              onTap: ()=> state.pageIndex == 0
                ? controller.addEditRoom.perform()
                : controller.addEditBed.perform(state: state)
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
                      title: "Phòng",
                      color: state.pageIndex == 0 ? MyColor.green : MyColor.sliver,
                      horizontal: 20,
                      vertical: 7,
                      onTap: () {
                        context.read<BedRoomBloc>().add(GetListBedBedRoomEvent(listBed: state.listBedAll));
                        context.read<BedRoomBloc>().add(SetPageIndexBedRoomEvent(0));
                      },
                    ),
                    const SizedBox(width: 20),
                    WidgetButton(
                      title: "Giường",
                      horizontal: 20,
                      vertical: 7,
                      color: state.pageIndex == 1 ? MyColor.green : MyColor.sliver,
                      onTap: () {
                        context.read<BedRoomBloc>().add(GetListBedBedRoomEvent(listBed: state.listBedAll));
                        context.read<BedRoomBloc>().add(SetPageIndexBedRoomEvent(1));
                      },
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(child: _body(state)),
            ],
          ),
        );
      }
    );
  }

  Widget _body(BedRoomState state) {
    if(controller.screenStateIsLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: WidgetShimmer(
          radius: 20,
          width: double.infinity,
        ),
      );
    } else if(controller.screenStateIsError) {
      return SizedBox(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                controller.errorWidget,
                const SizedBox(height: 10),
                Utilities.retryButton(() => controller.onGetMultiple(true)),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
    } else {
      return _list(state)[state.pageIndex];
    }
  }

  List<Widget> _list(BedRoomState state) {
    return [
      roomView(state),
      bedView(state),
    ];
  }
}