part of 'book_add_edit_bloc.dart';

class BookAddEditEvent {}

class GetStaffBookAddEditEvent extends BookAddEditEvent {
  List<list_staff.Data> listStaff;
  GetStaffBookAddEditEvent(this.listStaff);
}

class GetBedBookAddEditEvent extends BookAddEditEvent {
  List<list_bed.Data> listBed;
  GetBedBookAddEditEvent(this.listBed);
}

class GetServiceBookAddEditEvent extends BookAddEditEvent {
  List<list_service.Data> listService;
  GetServiceBookAddEditEvent(this.listService);
}

class ChoseDropDowBookAddEditEvent extends BookAddEditEvent {
  ModelDropDowStatus? statusValue;
  ModelDropDowStaff? staffValue;
  ModelDropDowBed? bedValue;
  ModelDropDowService? serviceValue;
  ChoseDropDowBookAddEditEvent({
    this.statusValue,
    this.bedValue,
    this.staffValue,
    this.serviceValue
  });
}

class SetBookingTypeBookAddEditEvent extends BookAddEditEvent {
  bool? isConsultation;
  bool? isCare;
  bool? isTreatmentPlan;
  bool? isTherapy;
  SetBookingTypeBookAddEditEvent({
    this.isConsultation,
    this.isTherapy,
    this.isTreatmentPlan,
    this.isCare
  });
}

class GetListCategoryServiceBookAddEditEvent extends BookAddEditEvent {
  List<cate_service.Data>? response;
  GetListCategoryServiceBookAddEditEvent(this.response);
}

class GetListRoomBookAddEditEvent extends BookAddEditEvent {
  List<list_room.Data>? listRoom;
  GetListRoomBookAddEditEvent(this.listRoom);
}

class SetValidateBookAddEditEvent extends BookAddEditEvent {
  String? vaPhone;
  String? vaStaff;
  String? vaService;
  String? vaBed;
  String? vaName;
  SetValidateBookAddEditEvent({
    this.vaBed,
    this.vaService,
    this.vaStaff,
    this.vaPhone,
    this.vaName
  });
}

class SetTitleScreenBookAddEditEvent extends BookAddEditEvent {
  String? titleButton;
  String? titleAppbar;
  SetTitleScreenBookAddEditEvent({this.titleButton, this.titleAppbar});
}