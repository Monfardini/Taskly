import 'package:flutter/material.dart';
import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/main_screen.dart';
//TODO:import 'screens/project_list.dart';
import 'screens/task_detail.dart';
import 'screens/settings.dart';

class TasklyApp extends StatelessWidget {
  const TasklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskly',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = const SplashScreen();
            break;
          case '/login':
            page = const LoginScreen();
            break;
          case '/register':
            page = const RegisterScreen();
            break;
          case '/home':
            page = const MainScreen();
            break;
          /*TODO:case '/projects':
            page = const ProjectListScreen();
            break;*/
          case '/task_detail':
            page = const TaskDetailScreen();
            break;
          case '/settings':
            page = const SettingsScreen();
            break;
          default:
            page = const SplashScreen();
        }

        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
        );
      },
    );
  }
}
