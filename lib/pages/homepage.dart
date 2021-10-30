import 'dart:convert';

import 'package:election_exit_poll_620710135/models/elecitem.dart';
import 'package:election_exit_poll_620710135/pages/scorepage.dart';
import 'package:election_exit_poll_620710135/services/api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class homePage extends StatefulWidget {

  static const routeName = '/home_page';
  const homePage({Key? key}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Future<List<elecItem>>? _canList;

  @override
  void initState() {
    super.initState();
    _canList = _load();
  }

  Future<List<elecItem>> _load() async {
    List list = await Api().fetch("exit_poll");
    var elecList = list.map((item) => elecItem.fromJson(item)).toList();
    return elecList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        // child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/vote_hand.png",
                  height: 120.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'EXIT POLL',
                    style:
                        GoogleFonts.prompt(fontSize: 23.0, color: Colors.white),
                  ),
                ),
                Text(
                  'เลือกตั้ง อบต.',
                  style:
                      GoogleFonts.prompt(fontSize: 23.0, color: Colors.white),
                ),
                Text(
                  'รายชื่อผู้สมัครรับเลือกตั้ง',
                  style:
                      GoogleFonts.prompt(fontSize: 17.0, color: Colors.white),
                ),
                Text(
                  'นายกองค์การบริหารส่วนตำบลเขาพระ',
                  style:
                      GoogleFonts.prompt(fontSize: 17.0, color: Colors.white),
                ),
                Text(
                  'อำเภอเมืองนครนายก จังหวัดนครนายก',
                  style:
                      GoogleFonts.prompt(fontSize: 17.0, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<List<elecItem>>(
                    future: _canList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        var elecList = snapshot.data;
                        return ListView.builder(
                          padding: EdgeInsets.all(8.0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: elecList!.length,
                          itemBuilder: (BuildContext context, int index) {
                            var elecItem = elecList[index];

                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              margin: EdgeInsets.all(8.0),
                              elevation: 5.0,
                              shadowColor: Colors.black.withOpacity(0.2),
                              color: Colors.white.withOpacity(0.7),
                              child: InkWell(
                                onTap: () => _handleClickCandidate(elecItem.number),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          elecItem.printnumber(),
                                          style: GoogleFonts.prompt(
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        elecItem.toString(),
                                        style: GoogleFonts.prompt(
                                            fontSize: 20.0),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ผิดพลาด: ${snapshot.error}'),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _canList = _load();
                                    });
                                  },
                                  child: Text('ลองใหม่')),
                            ],
                          ),
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(onPressed: () => _handlescore(), child: Text("ดูผลคะแนน",style: TextStyle(fontSize: 15.0),)),
                    ],
                  ),
                )
              ],
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //
            //   children: [
            //     ElevatedButton(onPressed: (){}, child: Text("ดูผลคะแนน",style: TextStyle(fontSize: 15.0),))
            //   ],
            // )
          ],
        ),
        // ),
      ),
    );
  }

  _handleClickCandidate(int electionItem) {
    _election(electionItem);
  }
  Future<void> _election(int candidateNumber) async {
    var elec = (await Api().submit('exit_poll', {'candidateNumber': candidateNumber}));
    _showMaterialDialog('SUCCESS', 'บันทึกข้อมูลสำเร็จ ${elec.toString()}');
  }
  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: TextStyle()),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _handlescore(){
    Navigator.pushNamed(
      context,
      scorePage.routeName,
     // arguments: foodItem,
    );
  }
}
