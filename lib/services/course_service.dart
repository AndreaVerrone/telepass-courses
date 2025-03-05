import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/services/auth_handler.dart';

class Course {
  final String id;
  final String title;
  final CourseType type;
  final int? modules;
  final int? questions;
  final int points;
  final String image;
  final double progress;
  final DateTime? completedAt;
  final DateTime? expiredAt;

  Course({
    required this.id,
    required this.title,
    required this.type,
    required this.modules,
    required this.questions,
    required this.points,
    required this.image,
    required this.progress,
    required this.completedAt,
    required this.expiredAt,
  });

  bool get isCompleted => progress == 1;
}

enum CourseType {
  servizi("servizi e applicativi"),
  compliance("compliance"),
  applicativi("applicativi");

  final String name;

  const CourseType(this.name);
}

final List<String> _courseNames = [
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  "Etiam eu ornare sem. Nullam in consectetur urna, ac dapibus nisl.",
  "Duis mattis purus nec felis sodales, dignissim fermentum libero ornare.",
  "Nunc molestie auctor consectetur. Vivamus eget tincidunt nunc.",
  "Suspendisse fringilla, risus ut commodo ultrices",
  "Metus erat tristique sapien, vel molestie elit.",
];

class CourseService {
  bool isSaved(Course course, BuildContext context) {
    return context.read<AuthHandler>().savedCourses.contains(course.id);
  }

  List<Course> getCourses() {
    return List.generate(30, (index) {
      final courseName = _courseNames[index % _courseNames.length];
      final courseType =
          CourseType.values[Random().nextInt(CourseType.values.length)];
      final hasModules = Random().nextBool();
      final propertyNumber = Random().nextInt(15);
      final points = Random().nextInt(10);
      final date = DateTime.now().subtract(const Duration(days: 3));
      final progress = min(1.0, Random().nextInt(120) / 100);
      final isExpired = Random().nextBool();
      return Course(
        id: index.toString(),
        title: courseName,
        type: courseType,
        modules: hasModules ? propertyNumber : null,
        questions: hasModules ? null : propertyNumber,
        points: points,
        image: "https://picsum.photos/id/${index * 3}/200",
        progress: progress,
        completedAt: progress == 1 ? date : null,
        expiredAt: isExpired ? date : null,
      );
    });
  }
}
