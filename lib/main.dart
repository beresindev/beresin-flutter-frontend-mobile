import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mobile_beresin/presentation/pages/auth/splash_screen.dart';
import 'package:mobile_beresin/providers/auth_provider.dart';
import 'package:mobile_beresin/providers/dashboard_provider.dart';
import 'package:mobile_beresin/providers/service_provider.dart';
import 'package:mobile_beresin/services/upload_service_source.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDateFormatting('id_ID', null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
