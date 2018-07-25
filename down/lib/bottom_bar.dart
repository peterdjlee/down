import 'package:down/pages/add_class_page.dart';
import 'package:down/colors.dart';
import 'package:down/pages/community_page.dart';
import 'package:down/pages/feed_page.dart';
import 'package:down/pages/profile_page.dart';
import 'package:down/pages/search_page.dart';
import 'package:flutter/material.dart';

import 'package:fluro/fluro.dart';

class BottomBar extends StatelessWidget {

  final router = new Router();
  var feedHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new FeedPage();
    }
  );
  var searchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new SearchPage();
    }
  );
  var addClassHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new AddClassPage();
    }
  );
  var communityHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new CommunityPage();
    }
  );
  var profileHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return new ProfilePage();
    }
  );

  void defineRoutes(Router router) {
    router.define("/FeedPage", handler: feedHandler);
    router.define("/SearchPage", handler: searchHandler);
    router.define("/AddClassPage", handler: addClassHandler);
    router.define("/CommunityPage", handler: communityHandler);
    router.define("/ProfilePage", handler: profileHandler);
  }

  String page = '';

  BottomBar({this.page}) {
    defineRoutes(router);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 50.0,
        alignment: Alignment.center,
        child: new BottomAppBar(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(
                icon: Icon(
                  Icons.people_outline,
                  size: 30.0,
                  color: page == 'CommunityPage' ? downPink : Colors.black,
                ),
                onPressed: () {
                  if (page != 'CommunityPage') {
                    if (page != 'FeedPage') Navigator.pop(context);
                    router.navigateTo(
                      context, 
                      "/CommunityPage",
                      transition: TransitionType.fadeIn
                    );
                  }
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.home,
                  size: 30.0,
                  color: page == 'FeedPage' ? downPink : Colors.black,
                ),
                onPressed: () {
                  if (page != 'FeedPage') {
                    Navigator.pop(context);
                  }
                }
              ),
              new IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: 30.0,
                  color: page == 'ProfilePage' ? downPink : Colors.black,
                ),
                onPressed: () {
                  if (page != 'ProfilePage') {
                    if (page != 'FeedPage') Navigator.pop(context);
                    router.navigateTo(
                      context, 
                      "/ProfilePage",
                      transition: TransitionType.fadeIn
                    );
                  }
                },
              ),
            ],
          ),
        ),
      );
  }
}