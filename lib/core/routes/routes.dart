import 'package:flutter/material.dart';
import 'package:tender/features/appointment/domain/di/di.dart';
import 'package:tender/features/appointment/presentation/view/appointment_view.dart';
import 'package:tender/features/chats/domain/di/di.dart';
import 'package:tender/features/chats/presentation/view/chats_view.dart';
import 'package:tender/features/dashboard/domain/di/di.dart';
import 'package:tender/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:tender/features/login/domain/di/di.dart';
import 'package:tender/features/login/presentation/view/login_view.dart';
import 'package:tender/features/messages/domain/di/di.dart';
import 'package:tender/features/patients_details/domain/di/di.dart';
import 'package:tender/features/patients_details/presentation/view/patients_details_view.dart';
import '../../features/messages/presentation/view/messages_view.dart';
import '../resources/manager_strings.dart';

/// A class defined for all routes constants
class Routes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String chats = '/chats';
  static const String messages = '/messages';
  static const String appointments = '/appointments';
  static const String patientsDetails = '/patientsDetails';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLogin();
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
        );
      case Routes.dashboard:
        initDashboard();
        return MaterialPageRoute(
          builder: (_) => DashboardView(),
        );
      case Routes.chats:
        initChats();
        return MaterialPageRoute(
          builder: (_) => const ChatsView(),
        );
      case Routes.messages:
        initMessages();
        return MaterialPageRoute(
          builder: (_) => const MessagesView(),
        );
      case Routes.appointments:
        initAppointments();
        return MaterialPageRoute(
          builder: (_) => const AppointmentsView(),
        );
      case Routes.patientsDetails:
        initPatientsDetails();
        return MaterialPageRoute(
          builder: (_) => const PatientsDetailsView(),
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
