import 'package:flutter/material.dart';
import 'package:telepass_courses/constants.dart';
import 'package:telepass_courses/services/faq_service.dart';
import 'package:telepass_courses/view/home/custom_tab_bar/custom_tab_bar.dart';
import 'package:telepass_courses/view/home/custom_tab_bar/tab_indicator.dart';
import 'package:telepass_courses/view/home/drawers/info_drawer.dart';
import 'package:telepass_courses/view/home/drawers/notification_drawer.dart';
import 'package:telepass_courses/view/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final tabs = [
    TabIndicatorData(icon: Icons.home_outlined, text: "Home"),
    TabIndicatorData(icon: Icons.menu_book, text: "Corsi"),
    TabIndicatorData(icon: Icons.description_outlined, text: "Knowledge"),
    TabIndicatorData(icon: Icons.person_outline, text: "Profilo"),
  ];
  late final TabController tabController = TabController(
    length: tabs.length,
    vsync: this,
  );

  Widget drawerToShow = const SizedBox();

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: Drawer(
        shape: const LinearBorder(),
        width: MediaQuery.sizeOf(context).width / 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  scaffoldKey.currentState?.closeEndDrawer();
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(child: drawerToShow),
            ],
          ),
        ),
      ),
      body: CustomTabBar(
        tabIndicators: tabs,
        tabController: tabController,
        horizontalPadding: 200,
        onInfoPressed: () {
          final faqs = FaqService().getFaqs();
          setState(() {
            drawerToShow = InfoDrawer(faqs: faqs);
          });
          scaffoldKey.currentState?.openEndDrawer();
        },
        onNotificationPressed: () {
          setState(() {
            drawerToShow = const NotificationDrawer();
          });
          scaffoldKey.currentState?.openEndDrawer();
        },
        pages: [ProfilePage()],
      ),
    );
  }
}
