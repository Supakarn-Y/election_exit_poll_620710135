import 'package:election_exit_poll_620710135/models/elecItem.dart';
import 'package:election_exit_poll_620710135/models/scoreitem.dart';
import 'package:election_exit_poll_620710135/services/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class scorePage extends StatefulWidget {
  static const routeName = '/score_page';
  const scorePage({Key? key}) : super(key: key);

  @override
  _scorePageState createState() => _scorePageState();
}

class _scorePageState extends State<scorePage> {
  Future<List<scoreItem>>? _scoreList;

  @override
  void initState() {
    super.initState();
    _scoreList = _scoreload();
  }

  Future<List<scoreItem>> _scoreload() async {
    List list = await Api().fetch("exit_poll/result");
    var scoreList = list.map((item) => scoreItem.fromJson(item)).toList();
    return scoreList;
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
        child: SafeArea(
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
                      style: GoogleFonts.prompt(
                          fontSize: 23.0, color: Colors.white),
                    ),
                  ),
                  Text(
                    'RESULT',
                    style:
                        GoogleFonts.prompt(fontSize: 23.0, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<List<scoreItem>>(
                      future: _scoreList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          var scoreList = snapshot.data;
                          return ListView.builder(
                            padding: EdgeInsets.all(8.0),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: scoreList!.length,
                            itemBuilder: (BuildContext context, int index) {
                              var scoreItem = scoreList[index];

                              return Card(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.all(8.0),
                                elevation: 5.0,
                                shadowColor: Colors.black.withOpacity(0.2),
                                color: Colors.white.withOpacity(0.7),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: <Widget>[
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      color: Colors.green,
                                      child: Center(
                                        child: Text(
                                          scoreItem.printnumber(),
                                          style: GoogleFonts.prompt(
                                              fontSize: 20.0),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      scoreItem.toString(),
                                      style: GoogleFonts.prompt(fontSize: 20.0),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        scoreItem.printscore(),
                                        style:
                                            GoogleFonts.prompt(fontSize: 20.0),
                                      ),
                                    ),
                                  ],
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
                                        _scoreList = _scoreload();
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
        ),
      ),
    );
  }
}
