
part of 'spa_add_edit_bloc.dart';

class SpaAddEditState {
  String? image;
  String vaNameSpa;
  String vaPhone;
  String vaAddress;
  String titleAppBar;
  String titleBtn;

  SpaAddEditState({
    this.image,
    this.vaPhone = "",
    this.vaNameSpa = "",
    this.vaAddress = "",
    this.titleAppBar = "Thêm mới cơ sở kinh doanh",
    this.titleBtn = "Thêm"
  });

  SpaAddEditState copyWith({
    String? image,
    String? vaNameSpa,
    String? vaPhone,
    String? vaAddress,
    String? titleAppBar,
    String? titleBtn,
  }) => SpaAddEditState(
    image: image ?? this.image,
    vaPhone: vaPhone ?? this.vaPhone,
    vaAddress: vaAddress ?? this.vaAddress,
    vaNameSpa: vaNameSpa ?? this.vaNameSpa,
    titleAppBar: titleAppBar ?? this.titleAppBar,
    titleBtn: titleBtn ?? this.titleBtn
  );
}

class InitSpaAddEditState extends SpaAddEditState {}