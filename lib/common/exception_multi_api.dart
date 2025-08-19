import 'package:spa_project/base_project/package.dart';

class ExceptionMultiApi {
  final Widget logo;
  final bool isNotError;

  const ExceptionMultiApi._({
    this.logo = const SizedBox(),
    this.isNotError = true,
  });

  factory ExceptionMultiApi.success() => const ExceptionMultiApi._(isNotError: true);

  factory ExceptionMultiApi.error({required Widget logo}) =>
      ExceptionMultiApi._(isNotError: false, logo: logo);
}
