import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';

class TabIndicatorData {
  final IconData icon;
  final String text;

  TabIndicatorData({required this.icon, required this.text});
}

class TabIndicator extends StatelessWidget {
  final TabIndicatorData tabIndicatorData;
  final bool isSelected;
  const TabIndicator({
    super.key,
    required this.isSelected,
    required this.tabIndicatorData,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? primaryColor : Colors.grey;
    return Column(
      children: [
        Icon(tabIndicatorData.icon, color: color),
        Text(tabIndicatorData.text, style: TextStyle(color: color)),
      ],
    );
  }
}
