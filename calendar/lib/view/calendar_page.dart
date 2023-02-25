import 'package:calendar/view/calendar_page1.dart';
import 'package:calendar/view/calendar_page2.dart';
import 'package:calendar/view/search.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        bottom: TabBar(
            controller: controller,
            indicatorColor: const Color.fromARGB(255, 255, 163, 72),
            labelColor: const Color.fromARGB(255, 255, 163, 72),
            unselectedLabelColor: const Color.fromARGB(255, 252, 199, 145),
            tabs: const [
              Tab(
                text: "달력",
              ),
              Tab(
                text: "일별",
              ),
              Tab(
                text: "검색",
              ),
            ]),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          CalendarPage1(),
          CalendarPage2(),
          SearchPage(),
        ],
      ),
    );
  }
}
