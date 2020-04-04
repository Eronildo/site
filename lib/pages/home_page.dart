import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:site/src/widgets/cursor/hand_cursor.dart';
import 'package:site/src/widgets/wave/wave.dart';
import 'package:site/src/widgets/wave/config.dart';
import 'package:site/utils/constants.dart';
import 'package:site/utils/theme.dart';

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
        CircleAvatar(radius: 80, backgroundImage: NetworkImage(Constants.urlPhoto),),
        
        SizedBox(height: 15,),
        getText(Constants.name, Colors.white54, 2.5),
        SizedBox(height: 15,),
        getText(Constants.jobTitle, Colors.white, 2.0),
        SizedBox(height: 10,),
        getText(Constants.description, Colors.white60, 1.5),

        Expanded(child: SizedBox(height: 1.0,)),

        actionsWidget,
        waveAnimatedWidget,
      ],
    );
  }

  Widget getText(String label, Color color, double scaleFactor) => Text(
    label,
    style: TextStyle(color: color,),
    textScaleFactor: scaleFactor,
    textAlign: TextAlign.center,
  );

  Widget getActionButton(String label, String imagePath, String url) => HandCursor(
    child: FlatButton.icon(
      icon: SizedBox(
        width: 20,
        height: 20,
        child: Image.asset(imagePath)
      ),
      label: Text(label),
      onPressed:() => html.window.open(url, label),
    ),
  );

  Widget get actionsWidget => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      getActionButton(Constants.labelLink_1, Constants.imgAssetsPathLink_1, Constants.urlLink_1),
      getActionButton(Constants.labelLink_2, Constants.imgAssetsPathLink_2, Constants.urlLink_2),
      getActionButton(Constants.labelLink_3, Constants.imgAssetsPathLink_3, Constants.urlLink_3),
    ],
  );

  Widget get waveAnimatedWidget => Flexible(
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
  );
}
