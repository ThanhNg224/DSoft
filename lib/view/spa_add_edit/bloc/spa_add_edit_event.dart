
part of 'spa_add_edit_bloc.dart';

class SpaAddEditEvent {}

class ChoseImageSpaAddEditEvent extends SpaAddEditEvent {
  String? image;
  ChoseImageSpaAddEditEvent(this.image);
}

class ValidateSpaAddEditEvent extends SpaAddEditEvent {
  String? vaNameSpa;
  String? vaPhone;
  String? vaAddress;

  ValidateSpaAddEditEvent({
    this.vaNameSpa,
    this.vaAddress,
    this.vaPhone
  });
}

class SetTitleViewSpaAddEditEvent extends SpaAddEditEvent {
  String? titleAppBar;
  String? titleBtn;

  SetTitleViewSpaAddEditEvent({this.titleBtn, this.titleAppBar});
}