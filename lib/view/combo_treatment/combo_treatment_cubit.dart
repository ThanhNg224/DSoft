import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_combo.dart';

class ComboTreatmentCubit extends Cubit<List<Data>> {
  ComboTreatmentCubit() : super(const []);

  void getComboTreatment(List<Data> data) => emit(data);
}