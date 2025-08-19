import 'package:flutter/material.dart';
import '../../models/gbl_card.dart';
import '../../config/constants.dart'; // For defaultPadding

class GblCardWidget extends StatelessWidget {
  final GblCard gblCard;
  final VoidCallback? onTap; // Optional tap action, e.g., to view model

  const GblCardWidget({
    super.key,
    required this.gblCard,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.defaultPadding / 2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: theme.colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gblCard.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: AppConstants.defaultPadding / 2),
              Text(
                gblCard.description,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
              if (gblCard.tags.isNotEmpty) ...[
                const SizedBox(height: AppConstants.defaultPadding),
                Wrap(
                  spacing: 8.0, // space between adjacent chips
                  runSpacing: 4.0, // space between lines
                  children: gblCard.tags.map((tag) => Chip(
                    label: Text(tag),
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    labelStyle: TextStyle(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: theme.colorScheme.primary.withOpacity(0.3)),
                    ),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
