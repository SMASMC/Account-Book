import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../model/calendar.dart';
import '../../repository/database_handler.dart';

class AddFloatingButton extends StatefulWidget {
  final StreamController<String> controller;
  final Stream<String> stream;
  const AddFloatingButton(
      {super.key, required this.stream, required this.controller});

  @override
  State<AddFloatingButton> createState() => _AddFloatingButtonState();
}

class _AddFloatingButtonState extends State<AddFloatingButton> {
//
  late DatabaseHandler handler;

  late String _selectedDate;

  // 수입 지출 스위치
  late bool _switch;
  // 수입 지출
  late String _status;

  Map<String, List> mySelectedEvents = {};

  final titleController = TextEditingController(); // 제목
  final amountController = TextEditingController(); // 금액
  final contentController = TextEditingController(); // 메모
  final incomController = TextEditingController(); // 수입
  final expenditureController = TextEditingController(); // 지출
  final categoryList = ["식비", "교통", "취미", "생활", "의류", "의료", "기타"];
  late String _selectedList = "식비";

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler(); //생성자
    _selectedList = categoryList[0];

    _selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    widget.stream.listen((selectDay) {
      // 날짜를 가지고 가서 list 불러오는 함수 불러오기
      setState(() {
        _selectedDate = selectDay;
      });
    });

    _switch = true;
    _status = "지출";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          elevation: 0,
          onPressed: () {
            _showAddEventDialog();
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // function
  _showAddEventDialog() async {
    await showDialog(
        barrierDismissible: false, // 바깥영역 터치시 창닫기 x
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text(
                "가계부 입력",
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(_status),
                        Switch(
                          value: _switch,
                          onChanged: (value) {
                            setState(() {
                              _switch = value;
                              _swichOnOff();
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("카테고리 선택 : "),
                        DropdownButton(
                          underline: const SizedBox.shrink(),
                          value: _selectedList,
                          items: categoryList.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          onChanged: (dynamic value) {
                            setState(() {
                              _selectedList = value;
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "선택된 카테고리 : $_selectedList",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    TextField(
                      maxLength: 10,
                      controller: titleController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: "제목"),
                    ),
                    TextField(
                      maxLength: 9,
                      controller: amountController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: "금액"),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    TextField(
                      maxLength: 10, // 글자수 제한
                      controller: contentController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(labelText: "메모"),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    titleController.clear();
                    amountController.clear();
                    contentController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isEmpty ||
                        amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("제목과 가격을 모두 입력해 주세요!"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      addCal();
                      widget.controller.add(_selectedDate);

                      titleController.clear();
                      amountController.clear();
                      contentController.clear();
                      Navigator.pop(context);
                      return;
                    }
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          });
        });
  }

  _swichOnOff() {
    if (_switch == true) {
      setState(() {
        _status = "지출";
        _switch = true;
      });
    } else {
      setState(() {
        _status = "수입";
        _switch = false;
      });
    }
  }

  // db에 데이터 저장
  Future<int> addCal() async {
    Calendar addCal = Calendar(
        title: titleController.text,
        inex: _status,
        income: _status == "지출" ? 0 : int.parse(amountController.text),
        expenditure: _status == "수입" ? 0 : int.parse(amountController.text),
        content: contentController.text,
        writeday: _selectedDate,
        category: _selectedList);

    await handler.insertCal(addCal);
    return 0;
  }
}
