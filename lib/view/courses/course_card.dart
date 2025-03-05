import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/course_service.dart';
import 'package:telepass_courses/view/components/separator.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final iconColor = course.isCompleted ? Colors.green : Colors.blue;
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        width: 350,
        height: 150,
        child: Row(
          children: [
            Stack(
              children: [
                Image.network(
                  course.image,
                  width: 300 / 4,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: iconColor.shade100,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.play_circle_outline_rounded,
                        color: iconColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: highlightColor,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          child: Text(
                            course.type.name,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Consumer<CourseService>(
                          builder: (context, service, child) {
                            return IconButton(
                              onPressed: () {
                                service.toggleSave(course, context);
                              },
                              padding: EdgeInsets.zero,
                              visualDensity: const VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              icon: Icon(
                                service.isSaved(course)
                                    ? Icons.star_rounded
                                    : Icons.star_outline_rounded,
                                color: primaryColor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const Separator(4),
                    Row(
                      children: [
                        if (course.modules != null)
                          Text(
                            "${course.modules} moduli",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        if (course.questions != null)
                          Text(
                            "${course.questions} domande",
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        const Separator(8),
                        const Icon(
                          Icons.workspace_premium_outlined,
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          "${course.points}P",
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                        const Separator(8),
                        if (course.completedAt != null) ...[
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 15,
                          ),
                          const Separator(2),
                          Text(
                            DateFormat.Md().format(course.completedAt!),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.green,
                            ),
                          ),
                        ],
                        if (!course.isCompleted &&
                            course.expiredAt != null) ...[
                          const Icon(
                            Icons.error_rounded,
                            color: Colors.orange,
                            size: 15,
                          ),
                          const Separator(2),
                          Text(
                            DateFormat.Md().format(course.expiredAt!),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const Separator(8),
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const Expanded(child: SizedBox()),
                    LinearProgressIndicator(
                      value: course.progress,
                      minHeight: 2,
                      color: course.isCompleted ? Colors.green : primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
