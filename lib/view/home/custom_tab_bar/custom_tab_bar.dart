import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/view/components/separator.dart';
import 'package:telepass_courses/view/home/custom_tab_bar/tab_indicator.dart';

class CustomTabBar extends StatefulWidget {
  final List<TabIndicatorData> tabIndicators;
  final List<Widget> pages;
  final TabController tabController;
  final double horizontalPadding;
  final VoidCallback onInfoPressed;
  final VoidCallback onNotificationPressed;

  const CustomTabBar({
    super.key,
    required this.tabIndicators,
    required this.tabController,
    required this.horizontalPadding,
    required this.pages,
    required this.onInfoPressed,
    required this.onNotificationPressed,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  void initState() {
    widget.tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding,
            vertical: 8,
          ),
          child: Row(
            children: [
              Hero(
                tag: appBarLogoHeroTag,
                child: SvgPicture.asset("assets/telepass_logo.svg", height: 40),
              ),
              const Separator(12),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.tabIndicators
                      .asMap()
                      .map(
                        (index, value) => MapEntry(
                          index,
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                widget.tabController.animateTo(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 12,
                                ),
                                child: TabIndicator(
                                  isSelected:
                                      index == widget.tabController.index,
                                  tabIndicatorData: value,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
              const Separator(12),
              IconButton(
                onPressed: widget.onInfoPressed,
                icon: const Icon(Icons.info_outline_rounded),
              ),
              const Separator(36),
              IconButton(
                onPressed: widget.onNotificationPressed,
                icon: const Icon(Icons.notifications_none_rounded),
              ),
            ],
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: widget.tabController.animation ??
                AlwaysStoppedAnimation(widget.tabController.index),
            builder: (context, child) {
              double opacity = 1;
              int start = widget.tabController.previousIndex;
              int end = widget.tabController.index;
              final animationValue = widget.tabController.animation?.value;
              if (animationValue != null) {
                opacity = ((animationValue - start) / (end - start)).clamp(
                  0.0,
                  1.0,
                );
              }
              return Opacity(opacity: opacity, child: child);
            },
            child: widget.pages.elementAtOrNull(widget.tabController.index) ??
                const Placeholder(
                  fallbackWidth: double.infinity,
                  fallbackHeight: double.infinity,
                ),
          ),
        ),
      ],
    );
  }
}
