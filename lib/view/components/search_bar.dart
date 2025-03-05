import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/view/components/separator.dart';

class CustomSearchBar extends StatelessWidget {
  final String title;
  final double horizontalPadding;
  final void Function(String)? onSearchComplete;
  const CustomSearchBar({
    super.key,
    required this.title,
    required this.horizontalPadding,
    this.onSearchComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: primaryColor,
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Separator(8),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, color: Colors.grey),
                const Separator(8),
                Expanded(
                  child: TextField(
                    onSubmitted: (value) {
                      onSearchComplete?.call(value);
                    },
                    decoration: const InputDecoration.collapsed(
                      hintText: "Cerca",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
