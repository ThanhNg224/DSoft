import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_partner.dart';

class ProductPartnerCubit extends Cubit<List<Data>> {
  ProductPartnerCubit() : super(const []);

  void getListProductPartnerCubit(List<Data> list)
  => emit(list);
}