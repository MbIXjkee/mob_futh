import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Внутренняя тень
class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    Key key,
    this.shadows = const <Shadow>[],
    Widget child,
  }) : super(key: key, child: child);

  final List<Shadow> shadows;

  @override
  RenderObject createRenderObject(BuildContext context) =>
      _RenderInnerShadow(shadows);

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject._shadows = shadows;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  List<Shadow> _shadows;

  _RenderInnerShadow(
    this._shadows, {
    RenderBox child,
  }) : super(child);

  List<Shadow> get shadows => _shadows;

  set shadows(List<Shadow> value) {
    if (_shadows == value) return;
    _shadows = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    final bounds = offset & size;

    context.canvas.saveLayer(bounds, Paint());
    context.paintChild(child, offset);

    for (final shadow in _shadows) {
      final shadowRect = bounds.inflate(shadow.blurSigma);
      final shadowPaint = Paint()
        ..blendMode = BlendMode.srcATop
        ..colorFilter = ColorFilter.mode(shadow.color, BlendMode.srcOut)
        ..imageFilter = ImageFilter.blur(
            sigmaX: shadow.blurSigma, sigmaY: shadow.blurSigma);
      context.canvas
        ..saveLayer(shadowRect, shadowPaint)
        ..translate(shadow.offset.dx, shadow.offset.dy);
      context.paintChild(child, offset);
      context.canvas.restore();
    }

    context.canvas.restore();
  }
}
