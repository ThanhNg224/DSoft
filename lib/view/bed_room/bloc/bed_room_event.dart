part of 'bed_room_bloc.dart';

class BedRoomEvent {}

class SetPageIndexBedRoomEvent extends BedRoomEvent {
  int? page;
  SetPageIndexBedRoomEvent(this.page);
}

class GetListRoomBedRoomEvent extends BedRoomEvent {
  List<room.Data>? listRoom;
  GetListRoomBedRoomEvent(this.listRoom);
}

class GetListBedBedRoomEvent extends BedRoomEvent {
  List<bed.Data>? listBed;
  List<bed.Data>? listBedAll;
  GetListBedBedRoomEvent({this.listBed, this.listBedAll});
}