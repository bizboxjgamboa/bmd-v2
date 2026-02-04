import 'dart:math';
import 'dart:ui';
import 'package:bmd_v2/app/routing/navigation_extensions.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  // ─────────────────────────────────────────────
  // MASTER TIMELINE (matches SplashPage)
  // ─────────────────────────────────────────────
  late final AnimationController _master;

  // ─────────────────────────────────────────────
  // ORANGE
  // ─────────────────────────────────────────────
  late AnimationController _orangeController;
  late Animation<double> _orangeSize;
  late Animation<double> _orangeOpacity;

  // ─────────────────────────────────────────────
  // BLUE
  // ─────────────────────────────────────────────
  late AnimationController _blueController;
  late Animation<double> _blueScale;
  late Animation<double> _blueSize;
  bool _showBlueCircle = false;

  static const int _particleCount = 12;

  // ─────────────────────────────────────────────
  // HELPERS
  // ─────────────────────────────────────────────

  double interval(double t, double start, double end) =>
      ((t - start) / (end - start)).clamp(0.0, 1.0);

  // ─────────────────────────────────────────────
  // INIT
  // ─────────────────────────────────────────────

  @override
  void initState() {
    super.initState();

    _master =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 4000),
          )
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              debugPrint('finished');
              context.goLogin();
            }
          })
          ..forward();

    _initOrange();
    _initBlue();

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!mounted) return;
      setState(() => _showBlueCircle = true);
      _blueController.forward();
    });
  }

  void _initOrange() {
    _orangeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _orangeSize = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 300.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(tween: ConstantTween(300.0), weight: 50),
      TweenSequenceItem(
        tween: Tween(
          begin: 300.0,
          end: 0.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
    ]).animate(_orangeController);

    _orangeOpacity = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _orangeController,
        curve: const Interval(0.9, 1.0),
      ),
    );
  }

  void _initBlue() {
    _blueController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );

    _blueScale = Tween<double>(begin: 0.05, end: 1.0).animate(
      CurvedAnimation(
        parent: _blueController,
        curve: const Interval(0.0, 0.545, curve: Curves.easeOut),
      ),
    );

    _blueSize = Tween<double>(begin: 300.0, end: 200.0).animate(
      CurvedAnimation(
        parent: _master,
        curve: const Interval(
          0.475, // 1900ms → dot reverse
          0.625, // 2500ms → dots end
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _master.dispose();
    _orangeController.dispose();
    _blueController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────
  // PARTICLES (EXACT COPY BEHAVIOR)
  // ─────────────────────────────────────────────

  List<Widget> _particles(double t) {
    final widgets = <Widget>[];

    for (int i = 0; i < _particleCount; i++) {
      final start = (500 + i * 50) / 4000;
      final end = (2500 + i * 50) / 4000;
      final p = interval(t, start, end);

      if (p <= 0) continue;

      final angle = (2 * pi / _particleCount) * i;

      final motion = p <= 0.7
          ? Curves.easeOut.transform(p / 0.7)
          : Curves.easeIn.transform((1 - p) / 0.3);

      final radius = lerpDouble(0, 80, motion)!;
      final offset = Offset(cos(angle) * radius, sin(angle) * radius);

      widgets.add(
        Transform.translate(
          offset: offset,
          child: Transform.scale(
            scale: lerpDouble(0.0, 1.5, motion)!,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i.isEven
                    ? const Color(0xFFFF5F47)
                    : const Color(0xFF0B2A45),
              ),
            ),
          ),
        ),
      );
    }
    return widgets;
  }

  Widget _logo(double t) {
    final p = interval(t, 1800 / 4000, 2600 / 4000);
    if (p <= 0) return const SizedBox.shrink();

    final scale = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOutBack)).transform(p);

    final blur = lerpDouble(20, 0, p)!;

    return Opacity(
      opacity: p,
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Transform.scale(
          scale: scale,
          child: Image.asset(
            'assets/images/splash/bizbox_splash.png',
            width: 80,
            height: 80,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _brandText(double t) {
    final p = interval(t, 2300 / 4000, 2900 / 4000);
    if (p <= 0) return const SizedBox.shrink();

    final eased = Curves.easeOut.transform(p);

    return Opacity(
      opacity: eased,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.translate(
            offset: Offset(lerpDouble(-50, 0, eased)!, 0),
            child: const Text(
              'bizbox',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFF0B2A45),
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    color: Color.fromARGB(40, 11, 42, 69),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(lerpDouble(50, 0, eased)!, 0),
            child: const Text(
              'MD',
              style: TextStyle(
                fontSize: 48,
                color: Color(0xFFFF5F47),
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 6,
                    color: Color.fromARGB(45, 255, 95, 71),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagline(double t) {
    final p = interval(t, 2600 / 4000, 3100 / 4000);
    if (p <= 0) return const SizedBox.shrink();

    final eased = Curves.easeOut.transform(p);

    return Opacity(
      opacity: eased,
      child: Transform.translate(
        offset: Offset(0, lerpDouble(10, 0, eased)!),
        child: const Text(
          'Your Business, Simplified',
          style: TextStyle(fontSize: 16, color: Color(0xff6d87aa)),
        ),
      ),
    );
  }

  Widget _loadingBar(double t, double width) {
    final containerP = interval(t, 2800 / 4000, 3200 / 4000);
    final fillP = interval(t, 2900 / 4000, 3900 / 4000);

    if (containerP <= 0) return const SizedBox.shrink();

    return Opacity(
      opacity: Curves.easeOut.transform(containerP),
      child: SizedBox(
        width: width * 0.5,
        height: 3,
        child: Stack(
          children: [
            // 🔹 Base bar (visible color)
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF5F47), Color(0xFF123257)],
                ),
              ),
            ),

            // 🔸 White overlay (reveals bar as it shrinks)
            Align(
              alignment: Alignment.centerLeft,
              child: Transform.scale(
                alignment: Alignment.centerRight, // ← THIS IS CRITICAL
                scaleX: lerpDouble(
                  1.0,
                  0.0,
                  Curves.easeInOut.transform(fillP),
                )!,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: _master,
        builder: (_, _) {
          final t = _master.value;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 240,
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _orangeCircle(),
                      _blueCircle(),
                      ..._particles(t),
                      _logo(t),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 64, child: _brandText(t)),
              const SizedBox(height: 16),
              SizedBox(
                height: 24, // correct height for 16px text
                child: _tagline(t),
              ),
              const SizedBox(height: 32),

              SizedBox(
                height: 4, // fixed layout
                child: _loadingBar(t, MediaQuery.of(context).size.width),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _orangeCircle() => AnimatedBuilder(
    animation: _orangeController,
    builder: (_, _) {
      if (_orangeController.value >= 1) return const SizedBox.shrink();
      return Opacity(
        opacity: _orangeOpacity.value,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
          child: Container(
            width: _orangeSize.value,
            height: _orangeSize.value,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFF5F47),
            ),
          ),
        ),
      );
    },
  );

  Widget _blueCircle() => !_showBlueCircle
      ? const SizedBox.shrink()
      : AnimatedBuilder(
          animation: _blueController,
          builder: (_, _) {
            return ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Transform.scale(
                scale: _blueScale.value,
                child: Container(
                  width: _blueSize.value,
                  height: _blueSize.value,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF123257),
                  ),
                ),
              ),
            );
          },
        );
}
