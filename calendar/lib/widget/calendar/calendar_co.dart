import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarCo extends StatefulWidget {
  final StreamController<String> controller;

  const CalendarCo({super.key, required this.controller});

  @override
  State<CalendarCo> createState() => _CalendarCoState();
}

class _CalendarCoState extends State<CalendarCo> {
  DateTime _focusedDay = DateTime.now(); // 오늘날짜
  DateTime? _selectedDate; // 선택한 날짜
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();

    _selectedDate = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(6),
      color: Colors.grey[200],
    );
    final defaultTextStyle =
        TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w700);
    return SizedBox(
      height: 300,
      width: 350,
      child: TableCalendar(
        locale: "ko_KR",
        shouldFillViewport: true,
        headerStyle:
            const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        focusedDay: _focusedDay,
        calendarStyle: CalendarStyle(
          defaultDecoration: defaultBoxDeco,
          weekendDecoration: defaultBoxDeco,
          todayDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffFFB973),
          ),
          selectedDecoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xffFFB973),
              width: 1,
            ),
          ),
          defaultTextStyle: defaultTextStyle,
          weekendTextStyle: defaultTextStyle,
          selectedTextStyle: defaultTextStyle.copyWith(
            color: const Color(0xffFFB973),
          ),
          outsideDecoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
        ),

        firstDay: DateTime(2020, 1, 1),
        lastDay: DateTime(2024, 12, 31),
        calendarFormat: _calendarFormat,
        onDaySelected: (
          selectedDay,
          focusedDay,
        ) {
          if (!isSameDay(_selectedDate, selectedDay)) {
            setState(() {
              _selectedDate = selectedDay;
              _focusedDay = focusedDay;
            });
            String day = DateFormat('yyyy-MM-dd').format(_selectedDate!);

            /// 날짜가 바뀌면 그날에 맞는 수입 지출 내역 가져오기
            /// list에 실행될 날짜를 바꿔주면 그만이ㅈ
            widget.controller.add(day);
          }
        },
        // 날짜 선택
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDate, day);
        },
        // 버튼
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        eventLoader: _listOfDayEvents,
      ),
    );
  }

// 이벤트로드
  Map<String, List> mySelectedEvents = {};
  List _listOfDayEvents(DateTime dateTime) {
    if (mySelectedEvents[DateFormat("yyyy-MM-dd").format(dateTime)] != null) {
      return mySelectedEvents[DateFormat("yyyy-MM-dd").format(dateTime)]!;
    } else {
      return [];
    }
  }
}
