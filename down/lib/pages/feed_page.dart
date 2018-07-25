import 'package:down/bottom_bar.dart';
import 'package:down/class_list.dart';
import 'package:down/pages/add_class_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {

  final router = new Router();
  final addClassHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new AddClassPage();
    }
  );

  void defineRoutes(Router router) {
    router.define("/AddClassPage", handler: addClassHandler);
  }

  FeedPage() {
    defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffFF9391),
        elevation: 1.0,
        title: Text(
          'Down',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
          )
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_circle_outline,
              size: 30.0,
              color: Colors.black,
            ),
            onPressed: () {
              router.navigateTo(
                context, 
                "/AddClassPage",
                transition: TransitionType.fadeIn
              );
            },
          )
        ] 
      ),
      body: ClassList('exampleclass'),
      bottomNavigationBar: BottomBar(page: 'FeedPage'),
    );
  }
}