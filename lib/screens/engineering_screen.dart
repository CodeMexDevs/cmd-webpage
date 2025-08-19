import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../models/gbl_card.dart';
import '../widgets/cards/gbl_card_widget.dart';
import '../config/routes.dart';

class EngineeringScreen extends StatelessWidget {
  const EngineeringScreen({super.key});

  // Hardcoded list of GBL card objects for demonstration
  static final List<GblCard> _gblCards = [
    const GblCard(
      title: 'Manofactura Aditiva',
      description: 'Creación de catálogos de industria, realidad virtual a tu alcance.',
      tags: ['Industria', 'Precisión', 'Manufactura'],
      modelPath: 'assets/models/robot.glb', // Example path to a GLB model
    ),
    const GblCard(
      title: 'Diseño de Prototipos en electrónica',
      description: 'El diseño asistido por computadora (CAD) beneficia al desarrollo de electrónica embebida.',
      tags: ['Electrónica', 'CAD', 'Arduino'],
      modelPath: 'assets/models/turbine.glb', // Example path to a GLB modelturbine.glb', // Placeholder for another model
    ),
    const GblCard(
      title: 'Investigación',
      description: 'Explora el diseño conceptual de cualquier idea en un visor 3D.',
      tags: ['Investigación', 'Prototipos', 'Interdisciplinario'],
      modelPath: 'assets/models/car.glb', // Example path to a GLB modelcar.glb', // Placeholder for another model
    ),
    const GblCard(
      title: 'Creatividad',
      description: 'Dale un toque creativo a tus proyectos.',
      tags: ['Creatividad', 'Productos', 'Diseño'],
      modelPath: 'assets/models/bridge.glb', // Example path to a GLB modelbridge.glb', // Placeholder for another model
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ingeniería'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800), // Max width for readability
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: ListView.builder(
            itemCount: _gblCards.length,
            itemBuilder: (context, index) {
              final card = _gblCards[index];
              return GblCardWidget(
                gblCard: card,
                onTap: card.modelPath != null
                    ? () {
                        // Navigate to the 3D viewer screen, passing the model path
                        Navigator.pushNamed(
                          context,
                          AppRoutes.threeDViewer,
                          arguments: card.modelPath,
                        );
                      }
                    : null, // No action if no model path
              );
            },
          ),
        ),
      ),
    );
  }
}
