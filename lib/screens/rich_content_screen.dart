import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../config/constants.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/image_carousel.dart'; // Import ImageCarousel for the carousel

class RichContentScreen extends StatefulWidget {
  final String contentPath;

  const RichContentScreen({
    super.key,
    required this.contentPath,
  });

  @override
  State<RichContentScreen> createState() => _RichContentScreenState();
}

class _RichContentScreenState extends State<RichContentScreen> {
  Map<String, dynamic>? _content;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      final String jsonString = await rootBundle.loadString(widget.contentPath);
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        _content = jsonData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = '${AppStrings.errorLoading}: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_content?['title'] ?? AppStrings.loading),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : SingleChildScrollView(
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 800),
                      padding: const EdgeInsets.all(AppConstants.defaultPadding),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppConstants.largePadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _content!['title'],
                                style: theme.textTheme.displayMedium,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              // Image Carousel
                              if (_content!['images'] != null && (_content!['images'] as List).isNotEmpty)
                                SizedBox(
                                  height: 300, // Fixed height for the carousel
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: ImageCarousel(
                                      imageUrls: List<String>.from(_content!['images']),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 32),
                              // Body Text
                              Text(
                                _content!['body'],
                                style: theme.textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              // Back Button
                              AppButton(
                                text: AppStrings.back,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
