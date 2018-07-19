import 'package:down/pages/add_class_page.dart';
import 'package:down/colors.dart';
import 'package:down/pages/community_page.dart';
import 'package:down/pages/feed_page.dart';
import 'package:down/pages/profile_page.dart';
import 'package:down/pages/search_page.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final String page = '';

  BottomBar({String page}) {
    print(page);
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
                    Icons.home,
                    size: 30.0,
                    color: page != 'FeedPage' ? downPink : Colors.black,
                  ),
                  onPressed: () {
                    if (page != 'FeedPage') Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => FeedPage())
                    );
                  },
              ),
              new IconButton(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: page == 'SearchPage' ? downPink : Colors.black,
                ),
                onPressed: () {
                  if (page != 'SearchPage') {
                    if (page != 'FeedPage') Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => SearchPage())
                   );
                  }
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  size: 30.0,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => AddClassPage())
                  );
                },
              ),
              new IconButton(
                icon: Icon(
                  Icons.people_outline,
                  size: 30.0,
                  color: page == 'CommunityPage' ? downPink : Colors.black,
                ),
                onPressed: () {
                  if (page != 'CommunityPage') {
                    if (page != 'FeedPage') Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => CommunityPage())
                    );
                  }
                },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => ProfilePage())
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