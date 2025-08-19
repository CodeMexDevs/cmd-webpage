import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ADDED
import 'package:url_launcher/url_launcher.dart'; // ADDED
import '../../config/constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  // ADDED: Helper function to launch URLs
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      padding: const EdgeInsets.all(AppConstants.largePadding),
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.copyright,
            style: TextStyle(color: textColor),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // MODIFIED: GitHub Icon
              IconButton(
                icon: FaIcon(FontAwesomeIcons.github, color: textColor),
                onPressed: () => _launchUrl('https://github.com/codemexdevs'), // Replace with your GitHub URL
              ),
              // MODIFIED: Facebook Icon
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook, color: textColor),
                onPressed: () => _launchUrl('https://www.instagram.com/codemexdevs'), // Replace with your Facebook URL
              ),
            ],
          ),
        ],
      ),
    );
  }
}