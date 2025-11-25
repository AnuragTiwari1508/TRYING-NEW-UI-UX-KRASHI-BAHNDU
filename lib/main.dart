import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'providers/theme_provider.dart';
import 'screens/admin_dashboard.dart';
import 'screens/farmer_dashboard.dart';
import 'screens/login_screen.dart';
import 'theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/farmer_dashboard',
      builder: (context, state) => const FarmerDashboard(),
    ),
    GoRoute(
      path: '/admin_dashboard',
      builder: (context, state) => const AdminDashboard(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          title: 'CROPIC Mobile',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          routerConfig: _router,
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
