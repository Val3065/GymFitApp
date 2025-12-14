import 'package:flutter/material.dart';
import 'ui/login_page.dart';
import 'ui/register_page.dart';
import 'ui/reset_password_page.dart';
import 'ui/home_page.dart';
import 'ui/routines_page.dart';
import 'ui/notifications_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings s) {
    switch (s.name) {
      case '/login': return _page(const LoginPage());
      case '/register': return _page(const RegisterPage());
      case '/reset': return _page(const ResetPasswordPage());
      case '/home': return _page(const HomePage());
      case '/routines': return _page(const RoutinesPage());
      case '/notifications': return _page(const NotificationsPage());
      default: return _page(const LoginPage());
    }
  }

  static MaterialPageRoute _page(Widget child) =>
      MaterialPageRoute(builder: (_) => child);
}