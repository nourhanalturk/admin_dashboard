import 'package:flutter/material.dart';
import 'package:tender/features/dashboard/domain/di/di.dart';
import 'package:tender/features/dashboard/presentation/view/dashboard_view.dart';
import '../resources/manager_strings.dart';

/// A class defined for all routes constants
class Routes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const Placeholder(),
        );
      case Routes.dashboard:
        initDashboard();
        return MaterialPageRoute(
          builder: (_) => DashboardView(),
        );


      default:
        return unDefinedRoute();
    }
  }

  /// If PushNamed Failed Return This Page With No Actions
  /// This Screen Will Tell The User This Page Is Not Exist
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
        body: Center(
          child: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
