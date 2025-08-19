import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeMyInfoCubit extends Cubit<String> {
  ChangeMyInfoCubit() : super("") {
    initChangeMyInfo();
  }

  void initChangeMyInfo() => emit("");

  void setAvatarChangeMyInfo(String path) => emit(path);
}