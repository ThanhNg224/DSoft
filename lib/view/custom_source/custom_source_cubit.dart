import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_source_custom.dart';

class CustomSourceCubit extends Cubit<List<Data>> {
  CustomSourceCubit() : super(const []);

  void getListCate(List<Data> list) => emit(list);
}