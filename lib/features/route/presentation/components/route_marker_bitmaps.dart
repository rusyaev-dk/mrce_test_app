import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';

sealed class RouteMarkerBitmaps {
  static Uint8List? _markerA;
  static Uint8List? _markerB;

  static Future<Uint8List> get markerA async =>
      _markerA ??= await _generate('A', const Color(0xFF43A047));

  static Future<Uint8List> get markerB async =>
      _markerB ??= await _generate('B', const Color(0xFFE53935));

  static Future<Uint8List> _generate(String letter, Color fill) async {
    const double size = 180;
    const double border = 8;
    const double radius = size / 2;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, const Rect.fromLTWH(0, 0, size, size));

    final fillPaint = Paint()..color = fill;
    canvas.drawCircle(const Offset(radius, radius), radius, fillPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = border;
    canvas.drawCircle(
      const Offset(radius, radius),
      radius - border / 2,
      borderPaint,
    );

    final paragraphBuilder =
        ui.ParagraphBuilder(
            ui.ParagraphStyle(textAlign: TextAlign.center, maxLines: 1),
          )
          ..pushStyle(
            ui.TextStyle(
              color: const Color(0xFFFFFFFF),
              fontSize: 88,
              fontWeight: FontWeight.w800,
            ),
          )
          ..addText(letter);

    final paragraph = paragraphBuilder.build()
      ..layout(const ui.ParagraphConstraints(width: size));

    canvas.drawParagraph(paragraph, Offset(0, (size - paragraph.height) / 2));

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }
}
