class ReelModel {
  final String title;
  final bool seen;
  final String image;

  ReelModel({required this.title, required this.seen, required this.image});
}

class ReelService {
  List<ReelModel> getReels() {
    return List.generate(
      15,
      (index) => ReelModel(
        title: "Reel $index",
        seen: index > 5,
        image: "https://picsum.photos/200",
      ),
    );
  }
}
