import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/utils/responsive.dart';

class TickerWidget extends StatefulWidget {
  final List<String> messages;
  final VoidCallback? onTap;
  const TickerWidget({super.key, required this.messages, this.onTap});

  @override
  State<TickerWidget> createState() => _TickerWidgetState();
}

class _TickerWidgetState extends State<TickerWidget>
    with TickerProviderStateMixin {
  // Mobile/Cycling state
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  // Web/Scrolling state
  late AnimationController _scrollController;

  @override
  void initState() {
    super.initState();
    // Initialize Mobile state
    _pageController = PageController();
    _startMobileTimer();

    // Initialize Web state
    _scrollController = AnimationController(vsync: this);
    _startWebScroll();
  }

  void _startMobileTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted && widget.messages.length > 1) {
        if (_currentPage < widget.messages.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _currentPage,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _startWebScroll() {
    String fullText = widget.messages.join('  •  ');
    int seconds = (fullText.length / 10).clamp(15.0, 90.0).toInt();
    _scrollController.duration = Duration(seconds: seconds);
    _scrollController.repeat();
  }

  @override
  void didUpdateWidget(TickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages != widget.messages) {
      _startWebScroll();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    if (widget.messages.isEmpty) return const SizedBox.shrink();

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: isMobile ? 36 : 42,
        decoration: const BoxDecoration(color: Color.fromRGBO(242, 169, 0, 1)),
        child: Row(
          children: [
            // Announcement Label
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: double.infinity,
              color: Colors.black.withValues(alpha: 0.1),
              child: const Center(
                child: Text(
                  'LATEST',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 10,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            // Content Area (Changes based on device)
            Expanded(
              child: isMobile ? _buildMobileCycling() : _buildWebScrolling(),
            ),
            // Icon
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.campaign, color: Colors.white38, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileCycling() {
    return PageView.builder(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.messages[index],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWebScrolling() {
    return ClipRect(
      child: AnimatedBuilder(
        animation: _scrollController,
        builder: (context, child) {
          return Align(
            alignment: Alignment(4.0 - (_scrollController.value * 8.0), 0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.messages.join('  •  '),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.2,
                ),
                maxLines: 1,
              ),
            ),
          );
        },
      ),
    );
  }
}
