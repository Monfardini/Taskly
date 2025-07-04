// main.dart (CORRIGIDO)
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/splash.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/main_screen.dart';
import 'screens/profile_setup.dart';
import 'screens/project.dart';
import 'screens/tasks_list.dart';
import 'screens/task_detail.dart';
import 'screens/dashboard.dart';
import 'screens/settings.dart';
import 'theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            initialRoute: '/',
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case '/':
                  return MaterialPageRoute(builder: (_) => const SplashScreen());
                case '/login':
                  return MaterialPageRoute(builder: (_) => const LoginScreen());
                case '/register':
                  return MaterialPageRoute(builder: (_) => const RegisterScreen());
                case '/main':
                  return MaterialPageRoute(builder: (_) => const MainScreen());
                case '/profileSetup':
                  return MaterialPageRoute(builder: (_) => const ProfileSetupScreen());
                case '/projects':
                  return MaterialPageRoute(builder: (_) => const ProjectScreen());
                case '/projectTasks':
                  final args = settings.arguments as Map<String, dynamic>? ?? {};
                  final projectId = args['projectId'] ?? '';
                  final projectTitle = args['projectTitle'] ?? '';
                  return MaterialPageRoute(
                    builder: (_) => TaskListScreen(
                      projectId: projectId,
                      projectTitle: projectTitle,
                    ),
                  );
                case '/task':
                  final args = settings.arguments as Map<String, dynamic>?;
                  final projectId = args != null ? args['projectId'] as String : '';
                  return MaterialPageRoute(
                      builder: (_) => TaskDetailScreen(projectId: projectId));
                case '/dashboard':
                  return MaterialPageRoute(builder: (_) => const DashboardScreen());
                case '/settings':
                  return MaterialPageRoute(builder: (_) => const SettingsScreen());
                default:
                  return MaterialPageRoute(builder: (_) => const SplashScreen());
              }
            },
          );
        },
      ),
    );
  }
}
