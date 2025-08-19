import 'package:spa_project/base_project/package.dart';

mixin BaseNavigator {
  BuildContext get context;

  Future<T?> pushName<T extends Object?>(String router, {Object? args})
  => Navigator.pushNamed(context, router, arguments: args);

  void pop<T extends Object?>([ T? result ])
  => Navigator.pop(context, result);

  Future<T?> pushReplacementNamed<T extends Object?>(String router, {Object? args})
  =>  Navigator.pushReplacementNamed(context, router, arguments: args);

  Future<void> pushNameRemoteAll(String router)
  => Navigator.pushNamedAndRemoveUntil(context, router, (route) => false);

  void popUntil(String router)
  => Navigator.popUntil(context, ModalRoute.withName(router));
}