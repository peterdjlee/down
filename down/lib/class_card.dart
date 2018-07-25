import 'package:cloud_firestore/cloud_firestore.dart';
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
    return FlatButton(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 184.0,
                child: new Stack(
                  children: <Widget>[
                    new Positioned.fill(
                      child: new Image.asset(
                        'assets/carmen-synergy.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: new Text(
                          documentSnapshot['title'],
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.black
                          ),
                        )
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
                                        fontSize: 15.0,
                                        color: Colors.black54
                                      ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 6.0,),
                          ],
                        ),
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
        router.navigateTo(
          context, 
          "/ClassPage",
          transition: TransitionType.fadeIn
        );
      },
    );
  }
}