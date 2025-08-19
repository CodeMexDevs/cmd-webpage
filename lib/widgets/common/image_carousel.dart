import 'package:flutter/material.dart';
import 'dart:async'; // Required for Timer
import '../../config/constants.dart'; // To get AppStrings.imageNotFound

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final Duration interval; // Interval for image change

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.interval = const Duration(seconds: 5), // Default to 5 seconds
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(widget.interval, (timer) {
      if (_pageController.hasClients) {
        _currentPage++;
        if (_currentPage >= widget.imageUrls.length) {
          _currentPage = 0; // Loop back to the first image
        }
        _pageController.animateToPage(
          _currentPage,
          duration: AppConstants.defaultAnimationDuration * 2, // Smooth animation
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.imageUrls.length,
      // Optional: Allow manual scrolling and reset timer
      onPageChanged: (index) {
        _currentPage = index;
        _timer?.cancel(); // Cancel current timer
        _startAutoScroll(); // Restart timer from new position
      },
      itemBuilder: (context, index) {
        return Image.asset(
          widget.imageUrls[index],
          fit: BoxFit.cover, // Cover the entire space
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 64,
                    color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppStrings.imageNotFound,
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? Colors.white54 : Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}