
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_bed.dart' as bed;
import 'package:spa_project/model/response/model_list_room.dart' as room;

part 'bed_room_event.dart';
part 'bed_room_state.dart';

class BedRoomBloc extends Bloc<BedRoomEvent, BedRoomState> {
  BedRoomBloc() : super(InitBedRoomState()) {
    on<SetPageIndexBedRoomEvent>((event, emit) {
      emit(state.copyWith(pageIndex: event.page));
    });
    on<GetListRoomBedRoomEvent>((event, emit) {
      emit(state.copyWith(listRoom: event.listRoom));
    });
    on<GetListBedBedRoomEvent>((event, emit) {
      emit(state.copyWith(listBed: event.listBed, listBedAll: event.listBedAll));
    });
  }
}