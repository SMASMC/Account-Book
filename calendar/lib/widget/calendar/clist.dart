import 'package:calendar/model/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../repository/database_handler.dart';

class Clist extends StatefulWidget {
  final Stream<String> stream;

  const Clist({super.key, required this.stream});

  @override
  State<Clist> createState() => _ClistState();
}

class _ClistState extends State<Clist> {
  // late DatabaseHandler handler; // DatabaseHandler 클라스로 만들어준 클라스
  var f = NumberFormat('###,###,###,###');
  late List<Calendar> list;

  @override
  void initState() {
    super.initState();
    list = [];
    myList(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    widget.stream.listen((event) {
      // 날짜를 가지고 가서 list 불러오는 함수 불러오기
      myList(event);
    });
  }

  // -----------------------------------------------
  // 날짜 변할 때 마다 새로운 리스트 가져오는 함수
  myList(String day) async {
    DatabaseHandler handler = DatabaseHandler();

    handler.queryYear(day).then((value) {
      setState(() {
        list = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(), // listView 스크롤 안되게
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: const EdgeInsets.all(0), // 카드간의 간격
            // elevation: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.13,
                    height: MediaQuery.of(context).size.width * 0.13,
                    child: CircleAvatar(
                      backgroundColor: list[index].inex == "수입"
                          ? const Color.fromARGB(255, 250, 187, 187)
                          : const Color.fromARGB(255, 177, 195, 255),
                      child: Text(
                        list[index].inex == "수입" ? '수입' : '지출',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: 18,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: Center(
                      child: Text(
                        list[index].category,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      list[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.01,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          list[index].expenditure == 0
                              ? "+ ${f.format(list[index].income)}원"
                              : "- ${f.format(list[index].expenditure)}원",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: list[index].expenditure == 0
                                ? const Color.fromARGB(255, 250, 187, 187)
                                : const Color.fromARGB(255, 177, 195, 255),
                          ),
                        ),
                        if (list[index].content != "") ...[
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            list[index].content,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                ],
              ),
            ),
          );
          // : Card(
          //     margin: const EdgeInsets.all(0), // 카드간의 간격
          //     elevation: 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.all(10),
          //           child: Row(
          //             children: [
          //               SizedBox(
          //                 height: 50,
          //                 width: 50,
          //                 child: CircleAvatar(
          //                   backgroundColor: list[index].inex == "수입"
          //                       ? const Color.fromARGB(255, 250, 187, 187)
          //                       : const Color.fromARGB(255, 177, 195, 255),
          //                   child: Text(
          //                     list[index].inex == "수입" ? '수입' : '지출',
          //                     style: const TextStyle(
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(
          //                 width: 20,
          //               ),
          //               Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Container(
          //                     width: 28,
          //                     height: 18,
          //                     decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(30),
          //                         border: Border.all(
          //                           color: Colors.grey,
          //                         )),
          //                     child: Center(
          //                       child: Text(
          //                         list[index].category,
          //                         style: const TextStyle(
          //                           color: Colors.grey,
          //                           fontSize: 10,
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                   const SizedBox(
          //                     width: 10,
          //                   ),
          //                   Text(
          //                     list[index].title,
          //                     style: const TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ],
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.all(16),
          //           child: Text(
          //             list[index].expenditure == 0
          //                 ? "+ ${f.format(list[index].income)}원"
          //                 : "- ${f.format(list[index].expenditure)}원",
          //             style: TextStyle(
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //               color: list[index].expenditure == 0
          //                   ? const Color.fromARGB(255, 250, 187, 187)
          //                   : const Color.fromARGB(255, 177, 195, 255),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   );
        });
  }
}
