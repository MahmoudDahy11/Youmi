import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppLaunchScreen extends StatefulWidget {
  const AppLaunchScreen({super.key});

  @override
  State<AppLaunchScreen> createState() => _AppLaunchScreenState();
}

class _AppLaunchScreenState extends State<AppLaunchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    Future<void>.delayed(const Duration(milliseconds: 1850), () {
      if (mounted) {
        context.go('/today');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoSize = size.shortestSide.clamp(112.0, 164.0);

    return Scaffold(
      backgroundColor: const Color(0xFF080A10),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.16),
            radius: 0.92,
            colors: [
              Color(0xFF18233F),
              Color(0xFF0C101A),
              Color(0xFF06070B),
            ],
            stops: [0, 0.52, 1],
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const _AmbientGlow(
              alignment: Alignment(-0.42, -0.34),
              color: Color(0x664FA8FF),
              size: 360,
            ),
            const _AmbientGlow(
              alignment: Alignment(0.46, 0.2),
              color: Color(0x554D34D8),
              size: 420,
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ParticleFieldPainter(_controller.value),
                );
              },
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          final pulse = 0.5 +
                              math.sin(_controller.value * math.pi * 2) * 0.5;

                          return Container(
                            width: logoSize,
                            height: logoSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF5AA7FF)
                                      .withValues(alpha: 0.20 + pulse * 0.08),
                                  blurRadius: 44,
                                  spreadRadius: 4,
                                ),
                                BoxShadow(
                                  color: const Color(0xFF8C62FF)
                                      .withValues(alpha: 0.14 + pulse * 0.07),
                                  blurRadius: 64,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: child,
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/images/app_icon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'Youmi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF5F7FB),
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: 104,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            minHeight: 3,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.08,
                            ),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF80B7FF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({
    required this.alignment,
    required this.color,
    required this.size,
  });

  final Alignment alignment;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IgnorePointer(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [color, Colors.transparent],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParticleFieldPainter extends CustomPainter {
  _ParticleFieldPainter(this.progress);

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    const particles = 26;

    for (var i = 0; i < particles; i++) {
      final seed = i * 0.618;
      final x = (math.sin(seed * 17.0) * 0.5 + 0.5) * size.width;
      final drift = (progress + seed) % 1.0;
      final y = (drift * size.height * 1.2) - size.height * 0.1;
      final opacity = math.sin(drift * math.pi).clamp(0.0, 1.0) * 0.16;
      final radius = 0.8 + (i % 4) * 0.28;

      paint.color = Color.lerp(
        const Color(0xFF75B7FF),
        const Color(0xFF9A78FF),
        (i % 7) / 6,
      )!
          .withValues(alpha: opacity);
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticleFieldPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
