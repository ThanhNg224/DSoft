part of 'customer_add_edit_bloc.dart';

class CustomerAddEditState {
  String avatar;
  String vaName;
  String vaPhone;
  bool isAddCustomer;
  ModelGender? currentGender;
  List<cate.Category> listCate;
  cate.Category? selectCate;
  List<source.Data> listSource;
  source.Data? selectSource;

  CustomerAddEditState({
    this.avatar = "",
    this.vaName = "",
    this.vaPhone = "",
    this.selectCate,
    this.isAddCustomer = true,
    this.currentGender,
    this.selectSource,
    this.listCate = const [],
    this.listSource = const [],
  });

  CustomerAddEditState copyWith({
    String? avatar,
    String? vaName,
    String? vaPhone,
    bool? isAddCustomer,
    ModelGender? currentGender,
    ModelDetailCustomer? dataDetail,
    bool setGenderNull = false,
    List<cate.Category>? listCate,
    List<source.Data>? listSource,
    cate.Category? selectCate,
    source.Data? selectSource,
  }) => CustomerAddEditState(
    avatar: avatar ?? this.avatar,
    vaName: vaName ?? this.vaName,
    vaPhone: vaPhone ?? this.vaPhone,
    isAddCustomer: isAddCustomer ?? this.isAddCustomer,
    currentGender: setGenderNull ? null : (currentGender ?? this.currentGender),
    listCate: listCate ?? this.listCate,
    selectCate: selectCate ?? this.selectCate,
    selectSource: selectSource ?? this.selectSource,
    listSource: listSource ?? this.listSource
  );
}

class InitCustomerAddEditState extends CustomerAddEditState {}