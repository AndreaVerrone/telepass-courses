import 'dart:math';

class Knowledge {
  final String id;
  final String title;
  final String subtitle;
  final KnowledgeType type;

  Knowledge({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
  });
}

enum KnowledgeType {
  servizi("servizi"),
  rete("la nostra rete");

  final String name;

  const KnowledgeType(this.name);
}

final List<String> _knowledgeNames = [
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
  "Etiam eu ornare sem. Nullam in consectetur urna, ac dapibus nisl.",
  "Duis mattis purus nec felis sodales, dignissim fermentum libero ornare.",
  "Nunc molestie auctor consectetur. Vivamus eget tincidunt nunc.",
  "Suspendisse fringilla, risus ut commodo ultrices",
  "Metus erat tristique sapien, vel molestie elit.",
];

class KnowledgeService {
  List<Knowledge> getKnowledges() {
    return List.generate(30, (index) {
      final title = _knowledgeNames[index % _knowledgeNames.length]
          .split(" ")
          .getRange(0, 3)
          .join(" ");
      final subtitle = _knowledgeNames[index % _knowledgeNames.length];
      final type =
          KnowledgeType.values[Random().nextInt(KnowledgeType.values.length)];

      return Knowledge(
        id: index.toString(),
        title: title,
        subtitle: subtitle,
        type: type,
      );
    });
  }
}
