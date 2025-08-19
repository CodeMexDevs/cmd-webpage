import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/content_screen.dart';
import '../screens/three_d_viewer_screen.dart';
import '../screens/engineering_screen.dart';
import '../screens/rich_content_screen.dart'; // IMPORT THE NEW SCREEN

class AppRoutes {
  static const String home = '/';
  static const String contact = '/contact';
  static const String features = '/features';
  static const String app = '/app';
  static const String threeDViewer = '/3d-viewer';
  static const String engineering = '/engineering';
  static const String artificialIntelligence = '/ai'; // NEW route for AI content
  static const String dataAnalysis = '/data-analysis'; // NEW route for Data Analysis content

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case contact:
        return MaterialPageRoute(
          builder: (_) => const ContentScreen(
            contentPath: 'assets/content/contacto.json',
          ),
        );
      case engineering:
        return MaterialPageRoute(builder: (_) => const EngineeringScreen());
      case artificialIntelligence: // Handle the new AI content route
        return MaterialPageRoute(
          builder: (_) => const RichContentScreen(
            contentPath: 'assets/content/ai.json',
          ),
        );
      case dataAnalysis: // Handle the new Data Analysis content route
        return MaterialPageRoute(
          builder: (_) => const RichContentScreen(
            contentPath: 'assets/content/data_analysis.json',
          ),
        );
      case threeDViewer:
        final String? modelPath = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => ThreeDViewerScreen(modelPath: modelPath));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
