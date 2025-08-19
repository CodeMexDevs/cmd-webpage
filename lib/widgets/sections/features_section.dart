import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../models/feature.dart';
import '../cards/feature_card.dart';
import '../common/responsive_layout.dart';

class FeaturesSection extends StatelessWidget {
  final BoxConstraints constraints;

  const FeaturesSection({
    super.key,
    required this.constraints,
  });

  static final List<Feature> _features = [
    const Feature(
      icon: Icons.palette,
      title: 'Personalizable',
      description: 'Cambio y adaptación de las aplicaciones a tu medida',
    ),
    const Feature(
      icon: Icons.phone_android,
      title: 'En todos lados',
      description: 'No pierdas el control de tus operaciones en ningún dispositivo',
    ),
    const Feature(
      icon: Icons.bolt,
      title: 'Rápido',
      description: 'Optimizado para una respuesta rápida y fluida en todas las plataformas',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.extraLargePadding,
        horizontal: AppConstants.defaultPadding,
      ),
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Text(
            AppStrings.featuresTitle,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 40),
          Text(
            AppStrings.featuresSubtitle,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ResponsiveLayout(
            mobile: Column(
              children: _features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: FeatureCard(feature: feature),
                      ))
                  .toList(),
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _features
                  .map((feature) => FeatureCard(feature: feature))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}