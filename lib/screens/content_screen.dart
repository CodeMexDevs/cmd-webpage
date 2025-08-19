import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../config/constants.dart';
import '../widgets/common/app_button.dart';
import '../widgets/common/content_card.dart';

class ContentScreen extends StatefulWidget {
  final String contentPath;

  const ContentScreen({
    super.key,
    required this.contentPath,
  });

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(_content?['title'] ?? AppStrings.loading),
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
                      child: ContentCard(
                        title: _content!['title'],
                        body: _content!['body'],
                        assetPath: _content!['asset'],
                        action: AppButton(
                          text: AppStrings.back,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}