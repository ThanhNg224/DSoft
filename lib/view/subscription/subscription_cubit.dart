import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/model/response/model_list_price_extend.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(InitSubscriptionState());

  void getListPackagesIOS(List<Package> list) => emit(state.copyWith(packagesIOS: list));

  void getListPackagesAndroid(List<ModelListPriceExtend> list) => emit(state.copyWith(packageAndroid: list));
}

class SubscriptionState {
  List<Package> packagesIOS;
  List<ModelListPriceExtend> packageAndroid;

  SubscriptionState({
    this.packagesIOS = const [],
    this.packageAndroid = const [],
  });

  SubscriptionState copyWith({
    List<Package>? packagesIOS,
    List<ModelListPriceExtend>? packageAndroid
  }) => SubscriptionState(
    packagesIOS: packagesIOS ?? this.packagesIOS,
    packageAndroid: packageAndroid ?? this.packageAndroid,
  );
}

class InitSubscriptionState extends SubscriptionState {}