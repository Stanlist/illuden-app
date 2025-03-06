import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../assets/constants.dart';
import '../../../utils/lights/lights.dart';


class SectionsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LightsCubit, LightsState>(
      builder: (context, state) {
        List<int> selectedSections = state.selectedSections;
        // double width = Constants.selectorWidth;
        // double height = Constants.selectorHeight;
        double width =  MediaQuery.of(context).size.width - Constants.selectorHorizontalPadding;
        double height = width + Constants.selectorVerticalPadding;
        double centerX = width / 2;
        double centerY = height / 2;
        return Center(
          child: SizedBox(
            width: width,
            height: height,
            child: GestureDetector(
              onTapDown: (details) {
                _onTap(context, details.localPosition, centerX, centerY);
              },
              child: CustomPaint(
                size: Size(width, height),
                painter: RadialLayerPainter(selectedSections: selectedSections, width: width, height: height),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context, Offset position, double centerX, double centerY) {
    double dx = position.dx - centerX;
    double dy = position.dy - centerY;
    double angle = atan2(dy, dx);
    double distance = sqrt(dx * dx + dy * dy);

    int layerIndex = _getLayerIndex(distance, centerX);
    int sectionIndex = _getSectionIndex(angle);

    if (layerIndex != -1 && sectionIndex != -1) {
      int section = layerIndex * 5 + sectionIndex;
      context.read<LightsCubit>().updateSelectedModules(section);
    }
  }

  int _getLayerIndex(double distance, double maxRadius) {
    double step = maxRadius / 3;
    if (distance < step) return 0;
    if (distance < 2 * step) return 1;
    if (distance < 3 * step) return 2;
    return -1;
  }

  int _getSectionIndex(double angle) {
    angle = (angle + 2 * pi) % (2 * pi);
    double sectionAngle = 2 * pi / 5;
    return (angle / sectionAngle).floor();
  }
}

class RadialLayerPainter extends CustomPainter {
  final List<int> selectedSections;
  final double width;
  final double height;

  RadialLayerPainter({required this.selectedSections, required this.width, required this.height});

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = width / 2;
    double centerY = height / 2;
    List<double> layerRadii = [width / 6, width / 3, width / 2];
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
      ..color = selectedSections.contains(section) ? Colors.deepPurple : Colors.grey
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
