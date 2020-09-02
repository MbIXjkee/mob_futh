import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circle',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  static final _shiftTween = Tween<double>(begin: -pi, end: pi);
  static final _aTween = Tween<double>(begin: -10.0, end: 10.0);
  static final _bTween = Tween<double>(begin: -70.0, end: 70.0);
  static final _cTween = Tween<double>(begin: -100.0, end: 100.0);
  static final _dTween = Tween<double>(begin: -200.0, end: 200.0);
  static final _eTween = Tween<double>(begin: -300.0, end: 300.0);

  static final _lightTween1 = ColorTween(
    begin: const Color(0xFFAAE9FF),
    end: const Color(0xFFD3F1FF),
  );
  static final _lightTween2 = ColorTween(
    begin: const Color(0xFFC896FF),
    end: const Color(0xFFE9BCFD),
  );

  static final _glowTween1 = ColorTween(
    begin: Color(0xFF4CC2E9),
    end: Color(0xFF82E3EB),
  );
  static final _glowTween2 = ColorTween(
    begin: Color(0xFF9C43FE),
    end: Color(0xFFE785FF),
  );

  static final _glowInterval = CurveTween(curve: Interval(0.9, 1.0));

  static final _curve = CurveTween(curve: Curves.easeInOut);

  AnimationController _shiftController;
  AnimationController _aController;
  AnimationController _bController;
  AnimationController _cController;
  AnimationController _dController;
  AnimationController _eController;

  AnimationController _glowController;

  @override
  void initState() {
    super.initState();

    final init = (int duration, double value) {
      return AnimationController(
        vsync: this,
        duration: Duration(milliseconds: duration),
        value: value,
      );
    };

    _shiftController = init(8000, 0.0);
    _aController = init(6000, 0.7);
    _bController = init(4000, 0.3);
    _cController = init(8000, 0.8);
    _dController = init(8000, 0.0);
    _eController = init(8000, 0.6);
    _glowController = init(4000, 0.0);

    _shiftController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _shiftController.forward(from: 0.0);
      }
    });

    [
      _aController,
      _bController,
      _cController,
      _dController,
      _eController,
      _glowController,
    ].forEach((c) {
      c.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          c.reverse();
        } else if (status == AnimationStatus.dismissed) {
          c.forward();
        }
      });

      c.forward();
    });

    _shiftController.forward();
  }

  @override
  void dispose() {
    _shiftController.dispose();
    _aController.dispose();
    _bController.dispose();
    _cController.dispose();
    _dController.dispose();
    _eController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Color(0xFF21457B),
              Color(0xFF252751),
              Color(0xFF1E0E2F),
            ],
            center: Alignment.topLeft,
            radius: 1.0,
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _shiftController,
            builder: (context, _) {
              return RepaintBoundary(
                child: CustomPaint(
                  painter: CirclePainter(
                    shift: _shiftTween.evaluate(_shiftController),
                    a: _aTween.chain(_curve).evaluate(_aController),
                    b: _bTween.chain(_curve).evaluate(_bController),
                    c: _cTween.chain(_curve).evaluate(_cController),
                    d: _dTween.chain(_curve).evaluate(_dController),
                    e: _eTween.chain(_curve).evaluate(_eController),
                    light1: _lightTween1
                        .chain(_glowInterval)
                        .chain(_curve)
                        .evaluate(_glowController),
                    light2: _lightTween2
                        .chain(_glowInterval)
                        .chain(_curve)
                        .evaluate(_glowController),
                    glow1: _glowTween1
                        .chain(_glowInterval)
                        .chain(_curve)
                        .evaluate(_glowController),
                    glow2: _glowTween2
                        .chain(_glowInterval)
                        .chain(_curve)
                        .evaluate(_glowController),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    this.shift,
    this.a,
    this.b,
    this.c,
    this.d,
    this.e,
    this.light1,
    this.light2,
    this.glow1,
    this.glow2,
  });

  final double shift;
  final double a;
  final double b;
  final double c;
  final double d;
  final double e;

  final Color light1;
  final Color light2;
  final Color glow1;
  final Color glow2;

  double getHarmonic(double x, double shift, List<double> components) {
    double y = 0;

    final angle = sin(x + shift);
    for (var i = 0; i < components.length; i++) {
      y += components[i] * angle / (i + 1);
    }

    return y;
  }

  Offset polarToCartesian({double distance, double angle}) {
    final x = distance * cos(angle);
    final y = distance * sin(angle);
    return Offset(x, y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    var points = <Offset>[];
    for (var i = 0; i <= pi * 2 * 10; i++) {
      final point = polarToCartesian(
        distance: 100.0 +
            getHarmonic(i / 10, shift, [
              a,
              b,
              c, /*d, e*/
            ]),
        angle: i / 10,
      );

      points.add(point);
    }

    path.addPolygon(points, true);

    final glowShader = LinearGradient(
      colors: [
        glow1,
        glow2,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      height: 110,
      width: 110,
    ));

    final strokeShader = LinearGradient(
      colors: [light1, light2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      height: 110.0,
      width: 110.0,
    ));

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..shader = glowShader
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 14.0);

    final strokePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18.0
      ..shader = strokeShader
      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 5.0);

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
