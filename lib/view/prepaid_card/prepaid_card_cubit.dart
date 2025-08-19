import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_prepaid_card.dart';

class PrepaidCardCubit extends Cubit<List<Data>> {
  PrepaidCardCubit() : super(const []);

  void getListPrepaidCard(List<Data> list) => emit(list);
}