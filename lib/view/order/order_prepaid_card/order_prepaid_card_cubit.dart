import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spa_project/model/response/model_order_prepaid_card.dart';

class OrderPrepaidCardCubit extends Cubit<List<Data>> {
  OrderPrepaidCardCubit() : super(const []);

  void onGetList(List<Data> list) => emit(list);
}