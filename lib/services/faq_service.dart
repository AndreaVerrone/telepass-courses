class FaqEntry {
  final String id;
  final String title;
  final String description;

  FaqEntry({required this.id, required this.title, required this.description});
}

class FaqService {
  List<FaqEntry> getFaqs() {
    return [
      FaqEntry(
        id: "1",
        title: "Come ottenere punti?",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu ornare sem. Nullam in consectetur urna, ac dapibus nisl. Duis mattis purus nec felis sodales, dignissim fermentum libero ornare. Nunc molestie auctor consectetur. Vivamus eget tincidunt nunc. Suspendisse fringilla, risus ut commodo ultrices, metus erat tristique sapien, vel molestie elit.",
      ),
      FaqEntry(
        id: "2",
        title: "Come ottenere badge?",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu ornare sem. Nullam in consectetur urna, ac dapibus nisl. Duis mattis purus nec felis sodales, dignissim fermentum libero ornare. Nunc molestie auctor consectetur. Vivamus eget tincidunt nunc. Suspendisse fringilla, risus ut commodo ultrices, metus erat tristique sapien, vel molestie elit.",
      ),
      FaqEntry(
        id: "3",
        title: "Come cambiare password?",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu ornare sem. Nullam in consectetur urna, ac dapibus nisl. Duis mattis purus nec felis sodales, dignissim fermentum libero ornare. Nunc molestie auctor consectetur. Vivamus eget tincidunt nunc. Suspendisse fringilla, risus ut commodo ultrices, metus erat tristique sapien, vel molestie elit.",
      ),
    ];
  }
}
