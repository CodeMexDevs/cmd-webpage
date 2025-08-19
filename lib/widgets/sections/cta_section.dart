import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // ADDED
import '../../config/constants.dart';
import '../common/app_button.dart';
import '../common/gradient_container.dart';

class CTASection extends StatelessWidget {
  const CTASection({super.key});

  // ADDED: Function to launch URLs
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  // ADDED: Function to show appointment options
  void _showAppointmentOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? Colors.grey[900] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            AppStrings.scheduleAppointment,
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDark ? Colors.white : Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.email, color: theme.colorScheme.primary),
                title: Text(
                  'Enviar correo a ${AppStrings.emailAddress}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close dialog
                  _launchUrl('mailto:${AppStrings.emailAddress}');
                },
              ),
              const Divider(),
              ListTile(
                leading: Icon(Icons.phone, color: theme.colorScheme.primary),
                title: Text(
                  'Llamar ${AppStrings.phoneNumber}',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close dialog
                  _launchUrl('tel:${AppStrings.phoneNumber}');
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'Cerrar',
                style: TextStyle(color: theme.colorScheme.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GradientContainer(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.extraLargePadding,
        horizontal: AppConstants.defaultPadding,
      ),
      child: Column(
        children: [
          Text(
            AppStrings.ctaTitle,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.ctaSubtitle,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          AppButton(
            text: AppStrings.scheduleAppointment,
            onPressed: () => _showAppointmentOptions(context), // MODIFIED
          ),
        ],
      ),
    );
  }
}