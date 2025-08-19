import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../models/testimonial.dart';
import '../cards/testimonial_card.dart';
import '../common/responsive_layout.dart';

class TestimonialsSection extends StatelessWidget {
  final BoxConstraints constraints;

  const TestimonialsSection({
    super.key,
    required this.constraints,
  });

  static final List<Testimonial> _testimonials = [
    const Testimonial(
      name: 'Dr. Alejandro Sosa',
      role: 'Consultor especializado en el sector energético.',
      quote: 'Las herramientas de análisis de datos son excepcionales. Me han ayudado a tomar decisiones más informadas.',
    ),
    const Testimonial(
      name: 'Dra. Ma. Cuevas',
      role: 'UAZ - Investigadora',
      quote: 'Estamos en pruebas con Chat MOFS una herramienta que puede ayudar a la investigación.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.extraLargePadding,
        horizontal: AppConstants.defaultPadding,
      ),
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          Text(
            AppStrings.testimonialsTitle,
            style: theme.textTheme.displayMedium,
          ),
          const SizedBox(height: 60),
          ResponsiveLayout(
            mobile: Column(
              children: _testimonials
                  .map((testimonial) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TestimonialCard(testimonial: testimonial),
                      ))
                  .toList(),
            ),
            desktop: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _testimonials
                  .map((testimonial) => TestimonialCard(testimonial: testimonial))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}