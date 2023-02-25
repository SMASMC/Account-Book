import 'dart:async';
import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  final StreamController<List> controller;
  const TopButton({super.key, required this.controller});

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  late TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '식비']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('식비'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '교통']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('교통'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '취미']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('취미'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '생활']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('생활'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '의류']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('의류'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '의료']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('의료'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.controller.add(['1', '기타']);
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffFFB973),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                ),
                elevation: 0.0,
              ),
              child: const Text('기타'),
            ),
          ),
        ],
      ),
    );
  }
}
