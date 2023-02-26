import 'dart:async';

import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
  final StreamController<List> controller;
  const SearchTextField({super.key, required this.controller});

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  late TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: '입력한 제목으로 검색',
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                setState(() {
                  widget.controller.add(['0', textController.text]);
                });
              },
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              widget.controller.add(['0', textController.text]);
            });
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
