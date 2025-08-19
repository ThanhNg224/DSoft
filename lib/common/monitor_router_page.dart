import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:spa_project/base_project/package.dart';

final class MonitorRouterPage extends RouteObserver<PageRoute<dynamic>> {

  _logDebug(String logContent) {
    if (kDebugMode) log(logContent, name: "RouterName");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute) _logDebug("BACK TO SCREEN: ${previousRoute.settings.name}");
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) _logDebug("REPLACED WITH SCREEN: ${newRoute.settings.name}");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) _logDebug("GO TO: ${route.settings.name}");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route is PageRoute) _logDebug("REMOVE WITH SCREEN: ${route.settings.name}");
  }
}
