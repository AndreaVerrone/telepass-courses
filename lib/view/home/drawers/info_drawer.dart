import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/faq_service.dart';
import 'package:telepass_courses/view/components/separator.dart';

class InfoDrawer extends StatelessWidget {
  final List<FaqEntry> faqs;
  const InfoDrawer({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "FAQ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Separator(32),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final faq = faqs[index];
                return ExpansionTile(
                  backgroundColor: primaryColorLight,
                  collapsedBackgroundColor: primaryColorLight,
                  collapsedIconColor: primaryColor,
                  iconColor: primaryColor,
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  childrenPadding: const EdgeInsets.all(16).copyWith(top: 0),
                  title: Text(
                    faq.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryColorDark,
                    ),
                  ),
                  children: [Text(faq.description)],
                );
              },
              separatorBuilder: (context, index) => const Separator(16),
              itemCount: faqs.length,
            ),
          ),
          const Divider(color: primaryColor),
          const Separator(24),
          const Text("Non hai trovato quello che cercavi?"),
          const Separator(16),
          FilledButton(
            onPressed: () {},
            child: const Align(child: Text("Contattaci")),
          ),
        ],
      ),
    );
  }
}
