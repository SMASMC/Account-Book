import 'package:calendar/model/date_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../model/calendar.dart';
import '../repository/database_handler.dart';

class CalendarPage2 extends StatefulWidget {
  const CalendarPage2({super.key});

  @override
  State<CalendarPage2> createState() => _CalendarPage2State();
}

class _CalendarPage2State extends State<CalendarPage2> {
  late DatabaseHandler handler; // DatabaseHandler 클라스로 만들어준 클라스
  late DateTime _dateTime;
  late TextEditingController startController;
  late TextEditingController endController;
  late List<String> year;
  late List<String> month;
  late List<String> day;
  late Future<List<Calendar>> calList;

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler(); //생성자
    _dateTime = DateTime.now();
    startController = TextEditingController();
    endController = TextEditingController();

    Date.year = [];
    Date.month = [];
    Date.day = [];

    for (var i = 1900; i <= _dateTime.year; i++) {
      Date.year.add('$i');
    }

    for (var i = 1; i <= 12; i++) {
      if (i < 10) {
        Date.month.add('0$i');
      } else {
        Date.month.add('$i');
      }
    }

    for (var i = 1; i <= 31; i++) {
      if (i < 10) {
        Date.day.add('0$i');
      } else {
        Date.day.add('$i');
      }
    }

    year = [
      _dateTime.year.toString(),
      _dateTime.year.toString(),
    ];

    month = [
      _dateTime.month < 10 ? '0${_dateTime.month}' : _dateTime.month.toString(),
      _dateTime.month < 10 ? '0${_dateTime.month}' : _dateTime.month.toString(),
    ];

    day = [
      _dateTime.day < 10 ? '0${_dateTime.day}' : _dateTime.day.toString(),
      _dateTime.day < 10 ? '0${_dateTime.day}' : _dateTime.day.toString(),
    ];

    endController.text = '${year[1]}-${month[1]}-${day[1]}';

    calList = handler.querySelectDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    '시작 날짜',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: TextFormField(
                      controller: startController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context, startController, 0),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    '종료 날짜',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.34,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: TextFormField(
                      controller: endController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      style: const TextStyle(
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                      ),
                      onTap: () => _selectDate(context, endController, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 94, 131, 251),
                  ),
                  onPressed: () {
                    setState(() {
                      calList = handler.querySpecificDate(
                          '${year[0]}-${month[0]}-${day[0]}',
                          '${year[1]}-${month[1]}-${day[1]}');
                    });
                  },
                  child: const Text(
                    '검색',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 248, 112, 112),
                  ),
                  onPressed: () {
                    setState(() {
                      calList = handler.querySelectDate();
                    });
                  },
                  child: const Text(
                    '초기화',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: calList, //데이터베이스 부르는거
              builder: (BuildContext context,
                  AsyncSnapshot<List<Calendar>> snapshot) {
                //데이터는 스냅샷에 들어있다
                if (snapshot.hasData) {
                  //데이터 있을경우
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (BuildContext context, int index) {
                      late Slidable cardWidget;

                      // query에서 불러온 결과 중에 내용이 들어있을 경우와 아닐경우에 각각 맞는 card를 만들기 위해서
                      if (snapshot.data![index].content != "") {
                        cardWidget = Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: null,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  print(1); // 바꿔야 됨
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 94, 131, 251),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: '수정',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  print(1); // 바꿔야 됨
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 248, 112, 112),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: '삭제',
                              ),
                            ],
                          ),
                          child: Card(
                            margin: const EdgeInsets.all(2), // 카드간의 간격
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              snapshot.data![index].inex == "지출"
                                                  ? const Color.fromARGB(
                                                      255, 177, 195, 255)
                                                  : const Color.fromARGB(
                                                      255, 250, 187, 187),
                                          child: Text(
                                            snapshot.data![index].inex == "수입"
                                                ? "수입"
                                                : "지출",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data![index].income == 0
                                            ? "-${snapshot.data![index].expenditure}원"
                                            : "+${snapshot.data![index].income}원",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              snapshot.data![index].income == 0
                                                  ? const Color.fromARGB(
                                                      255, 177, 195, 255)
                                                  : const Color.fromARGB(
                                                      255, 250, 187, 187),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshot.data![index].content,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        cardWidget = Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: null,
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  print(1); // 바꿔야 됨
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 116, 149, 255),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: '수정',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  print(1); // 바꿔야 됨
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 101, 101),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: '삭제',
                              ),
                            ],
                          ),
                          child: Card(
                            margin: const EdgeInsets.all(0),
                            elevation: 0, // 카드간의 간격
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              snapshot.data![index].inex == "지출"
                                                  ? const Color.fromARGB(
                                                      255, 177, 195, 255)
                                                  : const Color.fromARGB(
                                                      255, 250, 187, 187),
                                          child: Text(
                                            snapshot.data![index].inex == "수입"
                                                ? "수입"
                                                : "지출",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        snapshot.data![index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    snapshot.data![index].income == 0
                                        ? "-${snapshot.data![index].expenditure}원"
                                        : "+${snapshot.data![index].income}원",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: snapshot.data![index].income == 0
                                          ? const Color.fromARGB(
                                              255, 177, 195, 255)
                                          : const Color.fromARGB(
                                              255, 250, 187, 187),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      // 일별이 들어갈 텍스트 위젯
                      late Text day;

                      // 같은 일별로 카드를 하나씩만 찍어주기 위해서
                      if (index == 0) {
                        List<String> dayList =
                            snapshot.data![index].writeday.split('-');
                        day = Text(
                          '${dayList[0]}년 ${dayList[1]}월 ${dayList[2]}일',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else if (snapshot.data![index - 1].writeday ==
                          snapshot.data![index].writeday) {
                        day = const Text('');
                      } else {
                        List<String> dayList =
                            snapshot.data![index].writeday.split('-');

                        day = Text(
                          '${dayList[0]}년 ${dayList[1]}월 ${dayList[2]}일',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }

                      if (day.data == '') {
                        return cardWidget;
                      } else {
                        return Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                                child: day,
                              ),
                            ]),
                            cardWidget,
                          ],
                        );
                      }
                    },
                  );
                } else {
                  //데이터 없으면
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(
      BuildContext context, TextEditingController controller, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: const Center(
                  child: Text(
                    '날짜 선택',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 254, 155, 55),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CupertinoPicker.builder(
                        itemExtent: MediaQuery.of(context).size.width * 0.1,
                        childCount: Date.year.length,
                        scrollController: FixedExtentScrollController(
                          initialItem: Date.year.length - 1,
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            year[index] = Date.year[value];
                            controller.text =
                                '${year[index]}-${month[index]}-${day[index]}';
                          });
                        },
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              '${Date.year[index]}년',
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: CupertinoPicker(
                        itemExtent: MediaQuery.of(context).size.width * 0.1,
                        looping: true,
                        scrollController: FixedExtentScrollController(
                          initialItem: Date.month.indexOf(
                            _dateTime.month < 10
                                ? '0${_dateTime.month}'
                                : _dateTime.month.toString(),
                          ),
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            month[index] = Date.month[value];
                            controller.text =
                                '${year[index]}-${month[index]}-${day[index]}';
                          });
                        },
                        children: Date.month
                            .map(
                              (e) => Center(
                                child: Text(
                                  '$e월',
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: CupertinoPicker(
                        itemExtent: MediaQuery.of(context).size.width * 0.1,
                        looping: true,
                        scrollController: FixedExtentScrollController(
                          initialItem: Date.day.indexOf(
                            _dateTime.day < 10
                                ? '0${_dateTime.day}'
                                : _dateTime.day.toString(),
                          ),
                        ),
                        onSelectedItemChanged: (value) {
                          setState(() {
                            day[index] = Date.day[value];
                            controller.text =
                                '${year[index]}-${month[index]}-${day[index]}';
                          });
                        },
                        children: Date.day
                            .map(
                              (e) => Center(
                                child: Text(
                                  '$e일',
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  height: MediaQuery.of(context).size.height * 0.03,
                  color: Colors.black45,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextButton(
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
