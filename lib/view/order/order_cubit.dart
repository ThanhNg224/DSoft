import 'package:spa_project/base_project/package.dart';

class OrderCubit extends Cubit<int> {
  OrderCubit() : super(0);

  void onChangePageIndex(int index) => emit(index);
}