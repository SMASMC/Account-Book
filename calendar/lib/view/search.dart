import 'dart:async';

import 'package:calendar/widget/search/listview.dart';
import 'package:calendar/widget/search/search_text_field.dart';
import 'package:calendar/widget/search/top_button.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  StreamController<List> controller = StreamController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(child: TopButton(controller: controller)),
              SizedBox(child: SearchTextField(controller: controller)),
              Expanded(child: SearchListView(stream: controller.stream)),
            ],
          ),
        ),
      ),
    );
  }
}
