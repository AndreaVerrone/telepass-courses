import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/knowledge_service.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/search_bar.dart';
import 'package:telepass_courses/view/components/separator.dart';
import 'package:telepass_courses/view/knowledge/knowledge_card.dart';

class KnowledgePage extends StatefulWidget {
  final double horizontalPadding;
  const KnowledgePage({super.key, required this.horizontalPadding});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  final List<Knowledge> allKnowledges = [];
  List<Knowledge> filteredKnowledges = [];
  final List<String> quickFilters = [
    "Mostra tutti",
    "Da completare",
    "Obbligatori",
    "Preferiti",
    "In scadenza",
    "Facoltativi",
    "Completati",
    "Scaduti",
  ];
  late String selectedQuickFilter = quickFilters.first;
  String filterText = "";

  @override
  void initState() {
    allKnowledges.addAll(KnowledgeService().getKnowledges());
    filteredKnowledges = _filterKnowledges();
    super.initState();
  }

  List<Knowledge> _filterKnowledges() {
    if (filterText.isEmpty) return [...allKnowledges];
    return allKnowledges
        .where(
          (knowledge) =>
              knowledge.title.toLowerCase().contains(filterText.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          title: "Knowledge",
          horizontalPadding: widget.horizontalPadding,
          onSearchComplete: (searchString) {
            setState(() {
              filterText = searchString;
            });
          },
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: primaryColor)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                      quickFilters.map((quickFilter) {
                        final buttonStyle = const ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
                          textStyle: WidgetStatePropertyAll(
                            TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                        if (quickFilter == selectedQuickFilter) {
                          return FilledButton(
                            style: buttonStyle,
                            onPressed: () {
                              setState(() {
                                selectedQuickFilter = quickFilters.first;
                              });
                            },
                            child: Text(quickFilter),
                          );
                        } else {
                          return OutlinedButton(
                            style: buttonStyle,
                            onPressed: () {
                              setState(() {
                                selectedQuickFilter = quickFilter;
                              });
                            },
                            child: Text(quickFilter),
                          );
                        }
                      }).toList(),
                ),
              ),
              const Separator(32),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Knowledge",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () {},
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                          Color(0xFFE2EDFE),
                        ),
                        foregroundColor: const WidgetStatePropertyAll(
                          primaryColor,
                        ),
                        iconColor: const WidgetStatePropertyAll(primaryColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      label: const Text("Filtri"),
                      icon: const Icon(Icons.tune_rounded),
                    ),
                  ],
                ),
              ),
              const Separator(20),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding,
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 16,
                  children:
                      _filterKnowledges()
                          .map(
                            (knowledge) => KnowledgeCard(knowledge: knowledge),
                          )
                          .toList(),
                ),
              ),
              const Separator(20),
              const Footer(),
            ],
          ),
        ),
      ],
    );
  }
}
