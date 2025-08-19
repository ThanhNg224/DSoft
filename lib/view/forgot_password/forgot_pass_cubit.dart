import 'package:spa_project/base_project/package.dart';

class ForgotPassCubit extends Cubit<String> {
  ForgotPassCubit() : super("");

  void validateNumber(String validate) {
    emit(validate);
  }
}