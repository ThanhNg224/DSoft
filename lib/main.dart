import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:spa_project/base_project/package.dart';
import 'package:spa_project/common/monitor_router_page.dart';
import 'package:spa_project/common/multi_bloc.dart';
import 'package:spa_project/router/app_part.dart';
import 'package:spa_project/view/login/login_screen.dart';
import 'package:spa_project/view/multi_view/multi_view_screen.dart';

import 'view/chose_spa/chose_spa_screen.dart';

void main() async {
  Utilities.initSplash();
  await Global.load();
  WidgetsFlutterBinding.ensureInitialized();
  await Purchases.setDebugLogsEnabled(true);
  await Purchases.setup('appl_DNOfOwCSmZqeNiajLgeMTIxiCqS');
  runApp(const MultiBloc(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
        Locale('en', 'US'),
      ],
      title: 'DATA SPA',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [MonitorRouterPage()],
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: MyColor.slateBlue,
          selectionHandleColor: MyColor.slateBlue,
        ),
      ),
      onGenerateRoute: AppRouter.generateRoute,
      // initialRoute: Global.getString(MyConfig.TOKEN_STRING_KEY).isEmpty
      //     ? LoginScreen.router
      //     : MultiViewScreen.router
      initialRoute: (){
        if(Global.getString(MyConfig.TOKEN_STRING_KEY).isEmpty) return LoginScreen.router;
        if(Global.getString(Constant.defaultSpa).isEmpty) return ChoseSpaScreen.router;
        return MultiViewScreen.router;
      }()
    );
  }
}
