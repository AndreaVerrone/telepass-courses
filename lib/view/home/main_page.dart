import 'package:flutter/material.dart';
import 'package:telepass_courses/services/reel_service.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/reel.dart';
import 'package:telepass_courses/view/components/search_bar.dart';
import 'package:telepass_courses/view/components/separator.dart';

class MainPage extends StatelessWidget {
  final double horizontalPadding;
  final List<ReelModel> reels;
  const MainPage({
    super.key,
    required this.horizontalPadding,
    required this.reels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSearchBar(
          title: "Benvenuto!",
          horizontalPadding: horizontalPadding,
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 40),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Le novità del mondo Telepass",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Separator(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Rimani aggiornato su tutte le nostre novità",
                ),
              ),
              const Separator(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: SizedBox(
                  height: 122,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: reels.length,
                    itemBuilder:
                        (context, index) => Reel(reelModel: reels[index]),
                    separatorBuilder: (context, index) => const Separator(20),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Corsi in evidenza",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const Separator(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Lasciati guidare verso un percorso di apprendimento guidato",
                ),
              ),
              const Separator(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: SizedBox(
                  height: 122,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: reels.length,
                    itemBuilder:
                        (context, index) => Reel(reelModel: reels[index]),
                    separatorBuilder: (context, index) => const Separator(20),
                  ),
                ),
              ),
              const Separator(40),
              const Footer(),
            ],
          ),
        ),
      ],
    );
  }
}
