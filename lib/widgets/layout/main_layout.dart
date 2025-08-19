import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../../config/routes.dart';
import '../../providers/theme_provider.dart';
import '../chat/chat_widget.dart';
import 'responsive_app_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      extendBodyBehindAppBar: true,
      appBar: const ResponsiveAppBar(),
      body: Stack(
        children: [
          body,
          const Align(
            alignment: Alignment.bottomRight,
            child: ChatWidget(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              AppConstants.appName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            title: Text(isDark ? AppStrings.lightMode : AppStrings.darkMode),
            onTap: themeProvider.toggleTheme,
          ),
          ...AppConstants.menuItems.map((item) => ListTile(
                title: Text(item),
                onTap: () {
                  Navigator.pop(context);
                  if (item == 'Contacto') {
                    Navigator.pushNamed(context, AppRoutes.contact);
                  } else if (item == 'Ingeniería') {
                    Navigator.pushNamed(context, AppRoutes.engineering);
                  } else if (item == 'Inteligencia Artificial') { // Navigate to AI rich view
                    Navigator.pushNamed(context, AppRoutes.artificialIntelligence);
                  } else if (item == 'Análisis de datos') { // Navigate to Data Analysis rich view
                    Navigator.pushNamed(context, AppRoutes.dataAnalysis);
                  }
                },
              )),
        ],
      ),
    );
  }
}
