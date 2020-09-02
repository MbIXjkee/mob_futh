import 'package:flutter/material.dart';
import 'package:mob_futh/res/colors.dart';
import 'package:mob_futh/inner_shadow.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shadow Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Shadow button example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double blur = 10;
  double offsetX = 10;
  double offsetY = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 90,
            width: 90,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: shadowMainColor,
                    gradient: RadialGradient(
                      colors: [
                        shadowMainColor.withOpacity(0.0),
                        shadowMainColor,
                      ],
                      center: AlignmentDirectional(0.0, 0.5),
                      focal: AlignmentDirectional(0.0, 0.1),
                      focalRadius: 0.005,
                      radius: 0.95,
                      stops: [0.5, 1],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: shadowMainColor,
                    gradient: RadialGradient(
                      colors: [
                        shadowTintColor.withOpacity(0.0),
                        shadowTintColor,
                      ],
                      center: AlignmentDirectional(0.0, -0.5),
                      focal: AlignmentDirectional(0.0, 0.1),
                      focalRadius: 0.005,
                      radius: 0.95,
                      stops: [0.5, 1.0],
                    ),
                  ),
                ),
              ],
            ),
          ),
          InnerShadow(
            shadows: [
              Shadow(
                  color: shadowMainColor, blurRadius: 5, offset: Offset(0, 5)),
              Shadow(
                  color: shadowTintColor, blurRadius: 5, offset: Offset(0, -5)),
            ],
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90 / 2),
                  color: backgroundColor,
                ),
                height: 90,
                width: 90,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
