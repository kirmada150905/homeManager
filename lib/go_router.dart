import 'package:go_router/go_router.dart';
import 'package:home_manager/screens/detailed_room_view.dart';
import 'package:home_manager/screens/home_page.dart';
import 'package:home_manager/screens/info_page.dart';
import 'package:home_manager/screens/login_screen.dart';
import 'package:home_manager/screens/settings_page.dart';
import 'package:home_manager/screens/sing_up_screen.dart';

final go_router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginScreen(),
  ),
  GoRoute(
    path: '/sign_up',
    builder: (context, state) => SignUpScreen(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => SettingsPage(),
  ),
  GoRoute(
    path: '/detailed_room_view',
    builder: (context, state) {
      Map<String, dynamic> room = state.extra as Map<String, dynamic>;
      return DetailedRoomView(room: room);
    },
  ),
  GoRoute(
    path: '/info_page',
    builder: (context, state) {
      return InfoPage();
    },
  ),
]);
