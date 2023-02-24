import 'dart:async';

import 'package:calendar/widget/calendar/calendar_co.dart';
import 'package:calendar/widget/calendar/clist.dart';
import 'package:calendar/widget/calendar/current_status.dart';
import 'package:flutter/material.dart';

import '../widget/calendar/add_floating_button.dart';

class CalendarPage1 extends StatelessWidget {
  const CalendarPage1({super.key});

  @override
  Widget build(BuildContext context) {
    StreamController<String> controller = StreamController.broadcast();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CalendarCo(
                controller: controller,
              ),
              const SizedBox(
                height: 20,
              ),
              CurrentStatus(
                stream: controller.stream,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 150,
                child: Clist(
                  stream: controller.stream,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AddFloatingButton(
        stream: controller.stream,
        controller: controller,
      ),
    );
  }
}
