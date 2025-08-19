import 'package:spa_project/base_project/package.dart';

class ProductCubit extends Cubit<int> {
  ProductCubit() : super(0);

  void onChangePage(int index) => emit(index);
}