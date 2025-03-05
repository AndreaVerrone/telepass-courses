import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/extensions.dart';
import 'package:telepass_courses/view/components/separator.dart';

class CustomCarousel extends StatefulWidget {
  final List<Widget> items;
  final int itemsPerPage;
  final double itemsHeight;
  final double horizontalPadding;
  final bool pageSnapping;
  const CustomCarousel({
    super.key,
    required this.items,
    required this.itemsPerPage,
    required this.itemsHeight,
    required this.horizontalPadding,
    this.pageSnapping = false,
  });

  @override
  State<CustomCarousel> createState() => _CustomCarouselState();
}

class _CustomCarouselState extends State<CustomCarousel> {
  final carouselController = CarouselSliderController();
  late final numPages = (widget.items.length / widget.itemsPerPage).ceil();
  final double buttonSpacing = 50;
  final double buttonSize = 30;
  late final double actualHorizontalPadding = max(
    0,
    widget.horizontalPadding - (buttonSpacing + buttonSize),
  );

  final iconButtonStyle = const ButtonStyle(
    backgroundColor: WidgetStateColor.fromMap({
      WidgetState.disabled: Color(0xFFA9CDF4),
      WidgetState.any: primaryColor,
    }),
  );

  int currentPage = 0;

  void animateToPage(int page) {
    carouselController.animateToPage(page * widget.itemsPerPage);
  }

  void nextPage() {
    animateToPage(currentPage + 1);
  }

  void previousPage() {
    animateToPage(currentPage - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: actualHorizontalPadding),
      child: SizedBox(
        height: widget.itemsHeight + 20 + 20,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox.square(
                  dimension: buttonSize,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 17,
                    alignment: Alignment.center,
                    onPressed: currentPage == 0 ? null : previousPage,
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    style: iconButtonStyle,
                  ),
                ),
                Expanded(
                  child: CarouselSlider(
                    items: widget.items,
                    carouselController: carouselController,
                    options: CarouselOptions(
                      height: widget.itemsHeight,
                      enlargeCenterPage: false,
                      viewportFraction: 1 / widget.itemsPerPage,
                      pageSnapping: widget.pageSnapping,
                      enableInfiniteScroll: false,
                      padEnds: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPage = index ~/ widget.itemsPerPage;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox.square(
                  dimension: buttonSize,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 17,
                    alignment: Alignment.center,
                    onPressed: currentPage == numPages - 1 ? null : nextPage,
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    style: iconButtonStyle,
                  ),
                ),
              ].interleave(Separator(buttonSpacing)),
            ),
            const Separator(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(numPages, (index) {
                final isSelected = index == currentPage;
                final double size = isSelected ? 10 : 7;
                return MouseRegion(
                  cursor:
                      isSelected
                          ? SystemMouseCursors.basic
                          : SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap:
                        isSelected
                            ? null
                            : () {
                              animateToPage(index);
                            },
                    behavior: HitTestBehavior.opaque,
                    child: SizedBox.square(
                      dimension: 20,
                      child: Align(
                        child: Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? primaryColorDark : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).interleave(const SizedBox(width: 10)),
            ),
          ],
        ),
      ),
    );
  }
}
