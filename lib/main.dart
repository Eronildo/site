import 'package:flutter/material.dart';
import 'package:site/src/widgets/wave/wave.dart';
import 'package:site/src/widgets/wave/config.dart';
import 'package:site/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        Expanded(
          child: SizedBox(
            height: 500.0,
          ),
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

