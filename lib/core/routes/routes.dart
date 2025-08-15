import 'package:flutter/material.dart';
import 'package:tender/features/chats/domain/di/di.dart';
import 'package:tender/features/chats/presentation/view/chats_view.dart';
import 'package:tender/features/dashboard/domain/di/di.dart';
import 'package:tender/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:tender/features/messages/domain/di/di.dart';
import '../../features/messages/presentation/view/messages_view.dart';
import '../resources/manager_strings.dart';

/// A class defined for all routes constants
class Routes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String chats = '/chats';
  static const String messages = '/messages';


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
      case Routes.chats:
        initChats();
        return MaterialPageRoute(
          builder: (_) => ChatsView(),
        );
      case Routes.messages:
        initMessages();
        return MaterialPageRoute(
          builder: (_) => MessagesView(),
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
