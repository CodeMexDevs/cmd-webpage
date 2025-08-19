import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../common/app_button.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../common/gradient_container.dart'; // REMOVE THIS IMPORT, as GradientContainer is no longer directly used here
import '../common/image_carousel.dart'; // IMPORT THE NEW CAROUSEL WIDGET

class HeroSection extends StatelessWidget {

    // ADDED: Function to launch URLs
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
  final BoxConstraints constraints;

  const HeroSection({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine the overlay color based on theme for text readability
    final Color overlayColor = isDark
        ? Colors.black.withOpacity(0.5) // Dark overlay for dark theme
        : Colors.white.withOpacity(0.7); // Light overlay for light theme

    return SizedBox(
      height: constraints.maxHeight,
      width: double.infinity, // Ensure it takes full width
      child: Stack(
        children: [
          // 1. Background Image Carousel (Bottom layer)
          ImageCarousel(
            imageUrls: AppConstants.heroBackgroundImages,
            interval: const Duration(seconds: 5), // Set the 5-second interval
          ),

          // 2. Semi-transparent Overlay (Middle layer for readability)
          Container(
            color: overlayColor,
          ),

          // 3. Hero Content (Top layer)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.largePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstants.appName,
                    style: theme.textTheme.displayLarge?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    AppConstants.appTagline,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  AppButton(
                    text: AppStrings.getStarted,
                    onPressed: () => _launchUrl("https://cool-moray-assured.ngrok-free.app/"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}