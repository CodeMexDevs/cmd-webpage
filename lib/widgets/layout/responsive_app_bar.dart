import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/constants.dart';
import '../../config/routes.dart';
import '../../providers/theme_provider.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ResponsiveAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final showMenuItems = screenWidth > AppConstants.tabletBreakpoint;

    return AppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      actions: showMenuItems
          ? [
              ...AppConstants.menuItems.map((item) => TextButton(
                    onPressed: () {
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
                    child: Text(
                      item,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  )),
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                onPressed: themeProvider.toggleTheme,
              ),
              const SizedBox(width: AppConstants.defaultPadding),
            ]
          : null,
    );
  }
}
