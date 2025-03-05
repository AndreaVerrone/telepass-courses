import 'dart:math';

import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/course_service.dart';
import 'package:telepass_courses/services/knowledge_service.dart';
import 'package:telepass_courses/services/reel_service.dart';
import 'package:telepass_courses/view/components/custom_carousel.dart';
import 'package:telepass_courses/view/components/footer.dart';
import 'package:telepass_courses/view/components/reel.dart';
import 'package:telepass_courses/view/components/search_bar.dart';
import 'package:telepass_courses/view/components/separator.dart';
import 'package:telepass_courses/view/courses/course_card.dart';
import 'package:telepass_courses/view/knowledge/knowledge_card.dart';

class MainPage extends StatelessWidget {
  final double horizontalPadding;
  final List<ReelModel> reels;
  final TabController tabController;
  const MainPage({
    super.key,
    required this.horizontalPadding,
    required this.reels,
    required this.tabController,
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
              const Separator(50),
              CustomCarousel(
                items: [
                  const HighlightFeature(
                    title: "Scopri il mondo Telepass",
                    subtitle:
                        "L'obettivo principale è quello di fornire un ambiente interattivo  cui puoi acquisire conoscenze ondamentali e avanzate",
                  ),
                  const HighlightFeature(
                    title: "Esplora i nostro settori",
                    subtitle:
                        "Dall'innovazione tecnologica allaoddisfazione del cliente, dalla gestione delle operazioni alla sostenibilità aziendale",
                    lightVersion: true,
                  ),
                  const HighlightFeature(
                    title: "Parti insieme a noi",
                    subtitle:
                        "Siamo entusiasti di accompagnarti in questo viaggio di apprendimento. Preparati a scoprire, imparare e crescere",
                  ),
                ],
                itemsHeight: 250,
                horizontalPadding: horizontalPadding,
                itemsPerPage: 1,
                pageSnapping: true,
              ),
              const Separator(32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Corsi in evidenza",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Separator(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Lasciati guidare verso un percorso di apprendimento guidato",
                ),
              ),
              const Separator(40),
              CustomCarousel(
                items:
                    CourseService()
                        .getCourses()
                        .getRange(0, 12)
                        .map((course) => CourseCard(course: course))
                        .toList(),
                itemsHeight: 160,
                horizontalPadding: horizontalPadding,
                itemsPerPage: 3,
              ),
              const Separator(10),
              Center(
                child: TextButton(
                  onPressed: () {
                    tabController.animateTo(1);
                  },
                  child: const Text("Esplora tutti"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Divider(color: primaryColor, height: 100),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Knowledge in evidenza",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Separator(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Arricchisci la tua conoscenza ell'ecosistema Telepass",
                ),
              ),
              const Separator(40),
              CustomCarousel(
                items:
                    KnowledgeService()
                        .getKnowledges()
                        .getRange(0, 6)
                        .map((knowledge) => KnowledgeCard(knowledge: knowledge))
                        .toList(),
                itemsHeight: 120,
                horizontalPadding: horizontalPadding,
                itemsPerPage: 3,
              ),
              const Separator(10),
              Center(
                child: TextButton(
                  onPressed: () {
                    tabController.animateTo(2);
                  },
                  child: const Text("Esplora tutti"),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Divider(color: primaryColor, height: 100),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Classifica",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const Separator(8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const Text(
                  "Continua a migliorarti partecipando a nuove sfide",
                ),
              ),
              const Separator(40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [primaryColorDark, primaryColor],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: highlightColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Text(
                              "3°",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(color: Colors.white30, width: 1, height: 50),
                      Expanded(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipOval(
                                child: Image.network(
                                  "https://picsum.photos/50",
                                  height: 40,
                                ),
                              ),
                              const SizedBox(width: 20),
                              const Text(
                                "TU",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(color: Colors.white30, width: 1, height: 50),
                      const Expanded(
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.workspace_premium_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(width: 20),
                              Text(
                                "123 punti",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Separator(20),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Classifica completa"),
                ),
              ),
              const Separator(50),
              const Footer(),
            ],
          ),
        ),
      ],
    );
  }
}

class HighlightFeature extends StatelessWidget {
  final bool lightVersion;
  final String title;
  final String subtitle;
  const HighlightFeature({
    super.key,
    this.lightVersion = false,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final lightColor = lightVersion ? highlightColor : primaryColor;
    final darkColor = lightVersion ? const Color(0xFFFFA71A) : primaryColorDark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [lightColor, darkColor]),
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          SizedBox(
            height: 250,
            width: 300,
            child: Stack(
              children: [
                Positioned(
                  top: 20,
                  right: -25,
                  left: 30,
                  child: Transform.rotate(
                    angle: 15 * pi / 180,
                    child: Image.asset(
                      "assets/triangle-rounded.png",
                      color: darkColor.withAlpha(255 * 60 ~/ 100),
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  right: -10,
                  child: Transform.rotate(
                    angle: 15 * pi / 180,
                    child: Image.asset(
                      "assets/triangle-rounded.png",
                      height: 150,
                      color: Colors.white,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Separator(16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: lightVersion ? Colors.black : Colors.white,
                  ),
                ),
                const Separator(12),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: lightVersion ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 300),
        ],
      ),
    );
  }
}
