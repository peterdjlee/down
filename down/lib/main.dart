import 'package:down/colors.dart';
import 'package:down/pages/add_class_page.dart';
import 'package:down/pages/feed_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Down",
      debugShowCheckedModeBanner: false,
      home: new FeedPage(),
      theme: _downTheme,
    );
  }
}

final ThemeData _downTheme = _buildDownTheme();

ThemeData _buildDownTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: downSalmon,
    primaryColor: downPink,
    buttonColor: downPink,
    scaffoldBackgroundColor: downBackgroundWhite,
    cardColor: downBackgroundWhite,
    textSelectionColor: downPink,
    errorColor: downErrorRed,
    textTheme: _buildDownTextTheme(base.textTheme),
    primaryTextTheme: _buildDownTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildDownTextTheme(base.accentTextTheme),
    primaryIconTheme: base.iconTheme.copyWith(
      color: downSalmon
    ),
  );
}

TextTheme _buildDownTextTheme(TextTheme base) {
  return base.copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(
      fontSize: 18.0
    ),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  ).apply(
    // fontFamily: 'Rubik',
    // displayColor: downSalmon,
    // bodyColor: downSalmon,
  );
}