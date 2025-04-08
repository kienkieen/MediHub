import 'package:flutter/material.dart';
import 'dart:math' as math;

class Loader extends StatefulWidget {
  const Loader({super.key});

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with TickerProviderStateMixin {
  late AnimationController _controllerA;
  late AnimationController _controllerB;
  late AnimationController _controllerC;
  late AnimationController _controllerD;

  @override
  void initState() {
    super.initState();
    _controllerA = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    
    _controllerB = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    
    _controllerC = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    
    _controllerD = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    _controllerC.dispose();
    _controllerD.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 240,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ring A
            AnimatedBuilder(
              animation: _controllerA,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(240, 240),
                  painter: RingPainter(
                    progress: _controllerA.value,
                    color: const Color(0xFFF42F25),
                    type: RingType.a,
                  ),
                );
              },
            ),
            // Ring B
            AnimatedBuilder(
              animation: _controllerB,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(240, 240),
                  painter: RingPainter(
                    progress: _controllerB.value,
                    color: const Color(0xFFF49725),
                    type: RingType.b,
                  ),
                );
              },
            ),
            // Ring C
            AnimatedBuilder(
              animation: _controllerC,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(240, 240),
                  painter: RingPainter(
                    progress: _controllerC.value,
                    color: const Color(0xFF255FF4),
                    type: RingType.c,
                  ),
                );
              },
            ),
            // Ring D
            AnimatedBuilder(
              animation: _controllerD,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(240, 240),
                  painter: RingPainter(
                    progress: _controllerD.value,
                    color: const Color(0xFFF42582),
                    type: RingType.d,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum RingType { a, b, c, d }

class RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final RingType type;

  RingPainter({
    required this.progress,
    required this.color,
    required this.type,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Parameters based on the ring type
    double radius;
    double maxStrokeWidth;
    double minStrokeWidth = 20;
    double centerOffsetX = 0;
    double length;
    double maxArcLength;

    switch (type) {
      case RingType.a:
        radius = 105;
        maxStrokeWidth = 30;
        maxArcLength = 2 * math.pi * radius;
        
        // Determine animation stage and parameters
        if (progress < 0.04) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.12) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.04) / 0.08);
          length = lerpDouble(0, 60/660 * maxArcLength, (progress - 0.04) / 0.08);
        } else if (progress < 0.32) {
          paint.strokeWidth = maxStrokeWidth;
          length = 60/660 * maxArcLength;
        } else if (progress < 0.40) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.32) / 0.08);
          length = lerpDouble(60/660 * maxArcLength, 0, (progress - 0.32) / 0.08);
        } else if (progress < 0.54) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.62) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.54) / 0.08);
          length = lerpDouble(0, 60/660 * maxArcLength, (progress - 0.54) / 0.08);
        } else if (progress < 0.82) {
          paint.strokeWidth = maxStrokeWidth;
          length = 60/660 * maxArcLength;
        } else if (progress < 0.90) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.82) / 0.08);
          length = lerpDouble(60/660 * maxArcLength, 0, (progress - 0.82) / 0.08);
        } else {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        }
        
        // Draw the arc
        double startAngle = -math.pi / 2 + (progress * 3 * math.pi);
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          length / radius,
          false,
          paint,
        );
        break;
        
      case RingType.b:
        radius = 35;
        maxStrokeWidth = 30;
        maxArcLength = 2 * math.pi * radius;
        
        // Similar animation logic for Ring B
        if (progress < 0.12) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.20) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.12) / 0.08);
          length = lerpDouble(0, 20/220 * maxArcLength, (progress - 0.12) / 0.08);
        } else if (progress < 0.40) {
          paint.strokeWidth = maxStrokeWidth;
          length = 20/220 * maxArcLength;
        } else if (progress < 0.48) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.40) / 0.08);
          length = lerpDouble(20/220 * maxArcLength, 0, (progress - 0.40) / 0.08);
        } else if (progress < 0.62) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.70) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.62) / 0.08);
          length = lerpDouble(0, 20/220 * maxArcLength, (progress - 0.62) / 0.08);
        } else if (progress < 0.90) {
          paint.strokeWidth = maxStrokeWidth;
          length = 20/220 * maxArcLength;
        } else {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.90) / 0.10);
          length = lerpDouble(20/220 * maxArcLength, 0, (progress - 0.90) / 0.10);
        }
        
        // Draw the arc
        double startAngle = -math.pi / 2 + (progress * 3 * math.pi);
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          length / radius,
          false,
          paint,
        );
        break;
        
      case RingType.c:
        radius = 70;
        maxStrokeWidth = 30;
        maxArcLength = 2 * math.pi * radius;
        centerOffsetX = -35; // offset to the left
        
        // Animation logic for Ring C
        if (progress < 0.08) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.16) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.08) / 0.08);
          length = lerpDouble(0, 40/440 * maxArcLength, (progress - 0.08) / 0.08);
        } else if (progress < 0.28) {
          paint.strokeWidth = maxStrokeWidth;
          length = 40/440 * maxArcLength;
        } else if (progress < 0.36) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.28) / 0.08);
          length = lerpDouble(40/440 * maxArcLength, 0, (progress - 0.28) / 0.08);
        } else if (progress < 0.58) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.66) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.58) / 0.08);
          length = lerpDouble(0, 40/440 * maxArcLength, (progress - 0.58) / 0.08);
        } else if (progress < 0.86) {
          paint.strokeWidth = maxStrokeWidth;
          length = 40/440 * maxArcLength;
        } else {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.86) / 0.14);
          length = lerpDouble(40/440 * maxArcLength, 0, (progress - 0.86) / 0.14);
        }
        
        // Draw the arc
        final offsetCenter = Offset(center.dx + centerOffsetX, center.dy);
        double startAngle = -math.pi / 2 + (progress * 2 * math.pi);
        canvas.drawArc(
          Rect.fromCircle(center: offsetCenter, radius: radius),
          startAngle,
          length / radius,
          false,
          paint,
        );
        break;
        
      case RingType.d:
        radius = 70;
        maxStrokeWidth = 30;
        maxArcLength = 2 * math.pi * radius;
        centerOffsetX = 35; // offset to the right
        
        // Animation logic for Ring D
        if (progress < 0.08) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.16) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.08) / 0.08);
          length = lerpDouble(0, 40/440 * maxArcLength, (progress - 0.08) / 0.08);
        } else if (progress < 0.36) {
          paint.strokeWidth = maxStrokeWidth;
          length = 40/440 * maxArcLength;
        } else if (progress < 0.44) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.36) / 0.08);
          length = lerpDouble(40/440 * maxArcLength, 0, (progress - 0.36) / 0.08);
        } else if (progress < 0.58) {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        } else if (progress < 0.66) {
          paint.strokeWidth = lerpDouble(minStrokeWidth, maxStrokeWidth, (progress - 0.58) / 0.08);
          length = lerpDouble(0, 40/440 * maxArcLength, (progress - 0.58) / 0.08);
        } else if (progress < 0.78) {
          paint.strokeWidth = maxStrokeWidth;
          length = 40/440 * maxArcLength;
        } else if (progress < 0.86) {
          paint.strokeWidth = lerpDouble(maxStrokeWidth, minStrokeWidth, (progress - 0.78) / 0.08);
          length = lerpDouble(40/440 * maxArcLength, 0, (progress - 0.78) / 0.08);
        } else {
          paint.strokeWidth = minStrokeWidth;
          length = 0;
        }
        
        // Draw the arc
        final offsetCenter = Offset(center.dx + centerOffsetX, center.dy);
        double startAngle = -math.pi / 2 + (progress * 2 * math.pi);
        canvas.drawArc(
          Rect.fromCircle(center: offsetCenter, radius: radius),
          startAngle,
          length / radius,
          false,
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.color != color;
  }
  
  double lerpDouble(double a, double b, double t) {
    return a + (b - a) * t;
  }
}