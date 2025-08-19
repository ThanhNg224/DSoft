import 'package:spa_project/base_project/package.dart';

class ProductPartnerAddEditCubit extends Cubit<ProductPartnerAddEditState> {
  ProductPartnerAddEditCubit() : super(ProductPartnerAddEditState());

  void setValidate({String? vaName, String? vaPhone})
  => emit(state.copyWith(vaPhone: vaPhone, vaName: vaName));

  void setTitleApp(String? value)
  => emit(state.copyWith(titleApp: value));

}

class ProductPartnerAddEditState {
  String vaName;
  String vaPhone;
  String titleApp;

  ProductPartnerAddEditState({
    this.vaName = "",
    this.vaPhone = "",
    this.titleApp = "Thêm nhãn hiệu"
  });

  ProductPartnerAddEditState copyWith({String? vaName, String? vaPhone, String? titleApp})
  => ProductPartnerAddEditState(
      vaName: vaName ?? this.vaName,
      vaPhone: vaPhone ?? this.vaPhone,
      titleApp: titleApp ?? this.titleApp,
  );
}