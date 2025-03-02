import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/lights/lights.dart';


class SelectorView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        List<int> selectedModules = state.selectedModules;
        return Center(
          child: GestureDetector(
            onTapDown: (details) {
              _onTap(context, details.localPosition);
            },
            child: CustomPaint(
              size: Size(300, 300),
              painter: RadialLayerPainter(selectedModules: selectedModules),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, Offset position) {
    double centerX = 150;
    double centerY = 150;
    double dx = position.dx - centerX;
    double dy = position.dy - centerY;
    double angle = atan2(dy, dx);
    double distance = sqrt(dx * dx + dy * dy);

    int layerIndex = _getLayerIndex(distance);
    int sectionIndex = _getSectionIndex(angle);
    // print("Tapped at: ${position.dx}, ${position.dy}");

    if (layerIndex != -1 && sectionIndex != -1) {
      int section = layerIndex * 5 + sectionIndex;
      print("Tapped on section: $section (Layer $layerIndex, Section $sectionIndex)");
      context.read<LightsCubit>().updateSelectedModules(section);
    }
  }

  int _getLayerIndex(double distance) {
    if (distance < 50) return 0;
    if (distance < 100) return 1;
    if (distance < 150) return 2;
    return -1;
  }

  int _getSectionIndex(double angle) {
    angle = (angle + 2 * pi) % (2 * pi);
    double sectionAngle = 2 * pi / 5;
    return (angle / sectionAngle).floor();
  }
}

class RadialLayerPainter extends CustomPainter {
  final List<int> selectedModules;

  RadialLayerPainter({required this.selectedModules});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    List<double> layerRadii = [50.0, 100.0, 150.0];
    double sectionAngle = 2 * pi / 5;

    for (int layerIndex = 0; layerIndex < 3; layerIndex++) {
      double radiusStart = layerIndex == 0 ? 0 : layerRadii[layerIndex - 1];
      double radiusEnd = layerRadii[layerIndex];

      for (int section = 0; section < 5; section++) {
        double startAngle = section * sectionAngle;
        _drawSection(
          canvas,
          centerX,
          centerY,
          radiusStart,
          radiusEnd,
          startAngle,
          sectionAngle,
          layerIndex * 5 + section,
        );
      }
    }
  }

  void _drawSection(Canvas canvas, double centerX, double centerY, double radiusStart, double radiusEnd, double startAngle, double sweepAngle, int section) {
    final Paint paint = Paint()
      ..color = selectedModules.contains(section) ? Colors.deepPurple : Colors.grey
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(centerX, centerY)
      ..arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: radiusEnd), startAngle, sweepAngle, false)
      ..arcTo(Rect.fromCircle(center: Offset(centerX, centerY), radius: radiusStart), startAngle + sweepAngle, -sweepAngle, false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


