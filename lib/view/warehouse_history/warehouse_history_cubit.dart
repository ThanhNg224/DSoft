import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_warehouse_history.dart';

class WarehouseHistoryCubit extends Cubit<List<Data>> {
  WarehouseHistoryCubit() : super(const []);

  void getListWarehouseHistoryCubit(List<Data> list)
  => emit(list);
}