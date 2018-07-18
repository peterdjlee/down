import 'package:down/feed_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Down",
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: new FeedPage(),
    );
  }
}