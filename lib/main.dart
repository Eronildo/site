import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:site/src/widgets/cursor/hand_cursor.dart';
import 'package:site/src/widgets/wave/wave.dart';
import 'package:site/src/widgets/wave/config.dart';
import 'package:site/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eronildo.com',
      theme: AppTheme.theme(),
      home: Scaffold(
        body: Container(
          child: HomePage(),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  AnimationController _baseAnimation;
  Animation<double> _wavesAnimation;

  @override
  void initState() {
    super.initState();

    _baseAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..forward();
    _wavesAnimation = CurvedAnimation(
      parent: _baseAnimation,
      curve: const Interval(0.3, 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: SizedBox(height: 1.0,)),
        CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage("https://media-exp1.licdn.com/dms/image/C4D03AQH5yvp9zA7ZMQ/profile-displayphoto-shrink_100_100/0?e=1590624000&v=beta&t=vuR9zi58_N1Zb96JSfpm9kG5mFHqr__qP7YY6jJrkT0"),
          //backgroundImage: Image.asset("").image,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Eronildo Cavalcanti',
          style: Theme.of(context).textTheme.caption,
          textScaleFactor: 3,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Flutter Developer',
          style: Theme.of(context).textTheme.caption,
          textScaleFactor: 2,
          textAlign: TextAlign.center,
        ),
        Expanded(child: SizedBox(height: 1.0,)),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            HandCursor(
              child: FlatButton.icon(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('images/github.png')
                ),
                label: Text('Github'),
                onPressed:() => html.window.open("https://github.com/eronildo", 'eronildo.com' ),
              ),
            ),
            HandCursor(
              child: FlatButton.icon(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('images/twitter.png')
                ),
                label: Text('Twitter'),
                onPressed:() => html.window.open("https://twitter.com/eronildodotcom", 'eronildo.com' ),
              ),
            ),
            HandCursor(
              child: FlatButton.icon(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('images/linkedin.png')
                ),
                label: Text('LinkedIn'),
                onPressed:() => html.window.open("https://www.linkedin.com/in/eronildo/", 'eronildo.com' ),
              ),
            )
          ],
        ),
        Flexible(
          child: AnimatedBuilder(
            animation: _wavesAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0.0, 250 - (Curves.fastLinearToSlowEaseIn.transform(_wavesAnimation.value) * 250)),
                child: child,
              );
            },
            child: WaveWidget(
              config: WaveConfigCustom(
                gradients: [
                  [AppTheme.colorBackgroundLight, Colors.blue],
                  [Colors.blue[800], Colors.blue[300]],
                  [Colors.blue[900], AppTheme.colorBackgroundLight],
                  [AppTheme.colorDefaultGradientOne, AppTheme.colorDefaultGradientTwo],
                ],
                durations: [
                  35000,
                  19440,
                  10800,
                  6000,
                ],
                heightPercentages: [
                  0.20,
                  0.23,
                  0.25,
                  0.30,
                ],
                gradientBegin: Alignment.bottomLeft,
                gradientEnd: Alignment.topRight,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

