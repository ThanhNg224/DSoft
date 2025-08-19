part of 'bed_room_bloc.dart';

class BedRoomState {
  int pageIndex;
  List<room.Data> listRoom;
  List<bed.Data> listBed;
  List<bed.Data> listBedAll = [];

  BedRoomState({
    this.pageIndex = 0,
    this.listRoom = const [],
    this.listBed = const [],
    this.listBedAll = const []
  });

  BedRoomState copyWith({
    int? pageIndex,
    List<room.Data>? listRoom,
    List<bed.Data>? listBed,
    List<bed.Data>? listBedAll
  }) => BedRoomState(
    pageIndex: pageIndex ?? this.pageIndex,
    listRoom: listRoom ?? this.listRoom,
    listBed: listBed ?? this.listBed,
    listBedAll: listBedAll ?? this.listBedAll
  );
}

class InitBedRoomState extends BedRoomState {}