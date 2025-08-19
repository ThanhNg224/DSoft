import 'package:spa_project/base_project/package.dart';

import '../base_project/bloc/base_bloc.dart';

class MultiBloc extends StatelessWidget {
  final Widget child;

  const MultiBloc({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => BaseBloc(), lazy: true),
          BlocProvider(create: (_) => ToggleBlur(), lazy: true),
          BlocProvider(create: (_) => WidgetShimmerCubit(), lazy: true),
        ],
        child: child
    );
  }
}