import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_repo.dart';

class WarehouseCubit extends Cubit<List<Data>> {
  WarehouseCubit() : super(const []);

  void getListWarehouseCubit(List<Data> response)
  => emit(response);
}