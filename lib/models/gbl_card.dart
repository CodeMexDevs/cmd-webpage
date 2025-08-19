class GblCard {
  final String title;
  final String description;
  final List<String> tags;
  final String? modelPath; // Optional: path to a GLB model associated with the card

  const GblCard({
    required this.title,
    required this.description,
    this.tags = const [],
    this.modelPath,
  });
}
