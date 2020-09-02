import 'package:flutter/material.dart';
import 'package:mob_futh/button.dart';
import 'package:mob_futh/res/colors.dart';

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
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Button(
          isPressed: _isSelected,
          activatedColor: buttonEnabledColor,
          deactivatedColor: buttonDisabledColor,
          onPressed: () {
            setState(() {
              _isSelected = !_isSelected;
            });
          },
        ),
      ),
    );
  }
}
