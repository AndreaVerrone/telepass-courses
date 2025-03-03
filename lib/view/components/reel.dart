import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/reel_service.dart';
import 'package:telepass_courses/view/components/separator.dart';

class Reel extends StatelessWidget {
  final ReelModel reelModel;
  const Reel({super.key, required this.reelModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: reelModel.seen ? Colors.grey : highlightColor,
              width: 2,
            ),
          ),
          padding: const EdgeInsets.all(8),
          child: ClipOval(
            child: Image.network(
              reelModel.image,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                double? progress;
                if (loadingProgress.expectedTotalBytes != null) {
                  progress =
                      loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!;
                }
                return CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 2,
                  value: progress,
                );
              },
            ),
          ),
        ),
        const Separator(8),
        Text(
          reelModel.title,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}
