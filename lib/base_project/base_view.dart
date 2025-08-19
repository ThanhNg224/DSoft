import 'dart:developer';
import 'dart:io';
import 'package:spa_project/base_project/bloc/base_bloc.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/base_project/screen_state.dart';


/// function [findController] used to find the initialized controller to use the functions in it
/// Example: findController<ExampleController>().getFunction();

T findController<T extends BaseController>() {
  final controller = BaseView._controllers[T];
  if (controller == null) {
    throw Exception("Controller of type $T not found. Ensure it's registered via BaseView.");
  }
  return controller as T;
}

abstract class BaseView<T extends BaseController> extends StatefulWidget {
  const BaseView({super.key});

  static final Map<Type, BaseController> _controllers = {};
  static final Map<Type, BuildContext> _contexts = {};
  static final Map<Type, BaseState> _os = {};

  Widget zBuild();

  T createController(BuildContext context);

  T get controller => _controllers[T] as T;
  BuildContext get context => _contexts[T]!;
  BaseState get os => _os[T]!;

  B onTriggerEvent<B>() => (_controllers[T] as T).onTriggerEvent<B>();

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseController> extends State<BaseView<T>> {
  late T controller;

  @override
  void initState() {
    super.initState();
    controller = widget.createController(context);
    BaseView._controllers[T] = controller;
    BaseView._contexts[T] = context;
    BaseView._os[T] = context.read<BaseBloc>().state;
    _create(context);
    log("CREATED CONTROLLER: ${T.toString()}", name: MyConfig.APP_NAME);
  }

  void _create(BuildContext context) {
    context = this.context;
    controller.onInitState();
  }

  @override
  void dispose() {
    controller.onDispose();
    BaseView._controllers.remove(T);
    BaseView._contexts.remove(T);
    BaseView._os.remove(T);
    log("DISPOSE CONTROLLER: ${T.toString()}", name: MyConfig.APP_NAME);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller.onGetArgument();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BaseBloc, BaseState>(
      builder: (context, system) {
        BaseView._os[T] = system;
        return ValueListenableBuilder<ScreenStateEnum>(
          valueListenable: controller.stateNotifier,
          builder: (context, state, _) {
            return ColoredBox(
              color: MyColor.white,
              child: SafeArea(
                top: false,
                bottom: Platform.isIOS ? false : true,
                child: widget.zBuild()
              ),
            );
          },
        );
      },
    );
  }
}