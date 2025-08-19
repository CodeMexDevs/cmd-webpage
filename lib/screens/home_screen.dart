import 'package:flutter/material.dart';
import '../widgets/layout/main_layout.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/testimonials_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/cta_section.dart';
import '../widgets/sections/footer_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(constraints: constraints),
                TestimonialsSection(constraints: constraints),
                FeaturesSection(constraints: constraints),
                const CTASection(),
                const FooterSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}