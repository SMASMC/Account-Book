import 'package:calendar/model/calendar_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repository/database_handler.dart';

class CurrentStatus extends StatefulWidget {
  final Stream<String> stream;
  const CurrentStatus({super.key, required this.stream});

  @override
  State<CurrentStatus> createState() => _CurrentStatusState();
}

class _CurrentStatusState extends State<CurrentStatus> {
  late DatabaseHandler handler;
  var f = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.queryIncom().then((value) {
      setState(() {});
    });

    widget.stream.listen((event) {
      handler.queryIncom().then((value) {
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const textStyledefault = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffFFB973),
              ),
              child: const Center(
                child: Text(
                  "수입",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffFFB973),
              ),
              child: const Center(
                child: Text(
                  "지출",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xffFFB973),
              ),
              child: const Center(
                child: Text(
                  "합계",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                f.format(CalendartVM.ls[0]).toString(),
                textAlign: TextAlign.center,
                style: textStyledefault,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                f.format(CalendartVM.ls[1]).toString(),
                textAlign: TextAlign.center,
                style: textStyledefault,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                f.format(CalendartVM.ls[2]).toString(),
                textAlign: TextAlign.center,
                style: textStyledefault,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
