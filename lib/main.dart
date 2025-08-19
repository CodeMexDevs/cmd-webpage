import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:codemexdevs/config/constants.dart';
import 'config/routes.dart';
import 'providers/theme_provider.dart';
import 'theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async { // Make main async
  await dotenv.load(fileName: ".env"); // Load .env file
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const LandingPageApp(),
    ),
  );
}


class LandingPageApp extends StatelessWidget {
  const LandingPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          onGenerateRoute: AppRoutes.generateRoute,
          initialRoute: AppRoutes.home,
        );
      },
    );
  }
}