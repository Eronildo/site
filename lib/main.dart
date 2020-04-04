import 'package:flutter/material.dart';
import 'package:site/utils/theme.dart';
import 'package:site/utils/constants.dart';
import 'package:site/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.title,
      theme: AppTheme.theme(),
      home: Scaffold(
        body: Container(
          child: HomePage(),
        ),
      ),
    );
  }
}
