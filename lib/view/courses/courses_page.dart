import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/course_service.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/search_bar.dart';
import 'package:telepass_courses/view/components/separator.dart';
import 'package:telepass_courses/view/courses/course_card.dart';

class CoursesPage extends StatefulWidget {
  final double horizontalPadding;
  const CoursesPage({super.key, required this.horizontalPadding});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final List<Course> allCourses = [];
  List<Course> filteredCourses = [];
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
    allCourses.addAll(CourseService.getCourses());
    filteredCourses = _filterCourses();
    super.initState();
  }

  List<Course> _filterCourses() {
    if (filterText.isEmpty) return [...allCourses];
    return allCourses
        .where(
          (course) =>
              course.title.toLowerCase().contains(filterText.toLowerCase()),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CourseService(context),
      child: Column(
        children: [
          CustomSearchBar(
            title: "Corsi",
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
                        "Corsi",
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
                        _filterCourses()
                            .map((course) => CourseCard(course: course))
                            .toList(),
                  ),
                ),
                const Separator(20),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
