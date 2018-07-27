import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:down/colors.dart';
import 'package:down/pages/class_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class ClassCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  final router = new Router();

  ClassCard({this.documentSnapshot}) {
    defineRoutes(router);
  }

  var classHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new ClassPage();
    }
  );

  void defineRoutes(Router router) {
    router.define("/ClassPage", handler: classHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: FlatButton(
        child: Card(
          elevation: 0.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 184.0,
                  child: new Stack(
                    children: <Widget>[
                      new Positioned.fill(
                        child: new Image.asset(
                          'assets/images/carmen-synergy.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: downSalmon,
                              border: Border.all(
                                color: downSalmon,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15.0)
                              )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                documentSnapshot['organization'],
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: downSalmon,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // FittedBox(
                        //   fit: BoxFit.scaleDown,
                        //   alignment: Alignment.centerLeft,
                        //   child: new Text(
                        //     documentSnapshot['title'],
                        //     style: TextStyle(
                        //       fontSize: 24.0,
                        //       color: Colors.black
                        //     ),
                        //   )
                        // ),
                        Text(
                          documentSnapshot['title'],
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                documentSnapshot['date'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      documentSnapshot['instructor'],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                '${documentSnapshot['startTime']} ~ ${documentSnapshot['endTime']}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black
                                ),
                              )
                            ],
                          )
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              '\$${documentSnapshot['price'].toString()}',
                              style: TextStyle(
                                fontSize: 17.5,
                                color: Colors.black
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClassPage(
                documentSnapshot: documentSnapshot,
              )
            )
          );
          // router.navigateTo(
          //   context,
          //   "/ClassPage",
          //   transition: TransitionType.fadeIn
          // );
        },
      ),
    );
  }
}