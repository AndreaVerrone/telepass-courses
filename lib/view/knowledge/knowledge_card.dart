import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/knowledge_service.dart';
import 'package:telepass_courses/view/components/separator.dart';

class KnowledgeCard extends StatelessWidget {
  final Knowledge knowledge;
  const KnowledgeCard({super.key, required this.knowledge});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 350,
        height: 115,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: highlightColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  knowledge.type.name,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Separator(4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    knowledge.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                  IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    icon: const Icon(
                      Icons.star_outline_rounded,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const Separator(4),
              Padding(
                padding: const EdgeInsets.only(right: 60),
                child: Text(
                  knowledge.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
