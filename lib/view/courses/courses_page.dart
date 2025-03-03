import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
