import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import '../config/constants.dart'; // For AppStrings.errorLoading

class ThreeDViewerScreen extends StatelessWidget {
  final String? modelPath; // Make it nullable to allow default or passed path

  const ThreeDViewerScreen({super.key, this.modelPath});

  @override
  Widget build(BuildContext context) {
    // Use the passed modelPath, or a default one if not provided
    final String displayModelPath = modelPath ?? 'assets/models/robot.glb';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualizador 3D'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: displayModelPath.isNotEmpty
          ? Center(
              child: ModelViewer(
                src: displayModelPath, // Use the dynamic path
                alt: 'A 3D model for visualization',
                ar: true, // Enable Augmented Reality if supported on device
                autoRotate: true, // Automatically rotate the model
                cameraControls: true, // Allow user to pan, zoom, and rotate
                shadowIntensity: 1, // Add shadows for better realism
                backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Use Scaffold's background color
                
              ),
            )
          : Center(
              child: Text(
                '${AppStrings.errorLoading}: No model path provided.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
    );
  }
}
